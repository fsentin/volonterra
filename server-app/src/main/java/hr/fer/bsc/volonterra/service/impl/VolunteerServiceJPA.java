package hr.fer.bsc.volonterra.service.impl;

import java.sql.Date;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import hr.fer.bsc.volonterra.dto.EditVolunteerProfile;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.dto.VolunteerDTO;
import hr.fer.bsc.volonterra.dto.VolunteerDetailsForOrganization;
import hr.fer.bsc.volonterra.dto.VolunteerDetailsForVolunteer;
import hr.fer.bsc.volonterra.model.Login;
import hr.fer.bsc.volonterra.model.Volunteer;
import hr.fer.bsc.volonterra.repository.VolunteerRepository;
import hr.fer.bsc.volonterra.service.VolunteerService;
/**
 * JPA implementation of the service layer for volunteers.
 * @author Fani
 *
 */
@Service
public class VolunteerServiceJPA implements VolunteerService {
	
	@Autowired
	private VolunteerRepository repo;
	
	@Autowired
	private LoginServiceJPA logService;
	
	@Autowired
    private PasswordEncoder passwordEncoder;
	
	
	public List<VolunteerDTO> getAll() {
		return repo.findAll().stream()
				.map((v) -> new VolunteerDTO(v))
				.collect(Collectors.toList());
	}
	
	public VolunteerDetailsForOrganization getByIdForOrganization(Long id) {
		Optional<Volunteer> opVolunteer = repo.findById(id);
		if(opVolunteer.isEmpty()) return null;
		return new VolunteerDetailsForOrganization(opVolunteer.get());
	}
	
	public VolunteerDetailsForVolunteer getByIdForVolunteer(Long id) {
		Optional<Volunteer> opVolunteer = repo.findById(id);
		if(opVolunteer.isEmpty()) return null;
		return new VolunteerDetailsForVolunteer(opVolunteer.get());
	}
	
	public Volunteer getByIdPlain(Long id) {
		Optional<Volunteer> opVolunteer = repo.findById(id);
		if(opVolunteer.isEmpty()) return null;
		return opVolunteer.get();
	}

	public byte[] getImageById(Long id) {
		Optional<Volunteer> opVolunteer = repo.findById(id);
		if(opVolunteer.isEmpty()) return null;
		
		return opVolunteer.get().getPicByte();
	}
	
	public void saveVolunteer(Volunteer v) {
		repo.save(v);
	}
	
	public List<OpportunityDTO> getRecentAcceptedOpportunities(Long id){
		Volunteer vol = getByIdPlain(id);
		return vol.getAcceptedOpportunities().stream()
			.filter((o) -> o.getStartDate().after(new Date(System.currentTimeMillis())))
			.map((o) -> new OpportunityDTO(o))
			.collect(Collectors.toList());	
	}
	
	public List<OpportunityDTO> getAppliedOpportunities(Long id){
		Volunteer vol = getByIdPlain(id);
		return vol.getAppliedOpportunities().stream()
			.map((o) -> new OpportunityDTO(o))
			.collect(Collectors.toList());	
	}
	
	public boolean editProfile(EditVolunteerProfile e) {
		Volunteer vol = getByIdPlain(e.getId());
		if(vol == null) return false;
		
		if(!passwordEncoder.matches(e.getPassword(), vol.getLogin().getPassword()) ||
		   e.getFirstName().isEmpty() || 
		   e.getLastName().isEmpty() || 
		   e.getPassword().isEmpty() || 
		   e.getEmail().isEmpty()
		  ) {
			System.out.println("Nesto je empty");
			System.out.println("Kriva je sifra" + !passwordEncoder.matches(e.getPassword(), vol.getLogin().getPassword()));
			System.out.println( e.getFirstName().isEmpty());
			System.out.println(e.getLastName().isEmpty());
			System.out.println(e.getPassword().isEmpty());
			System.out.println(e.getEmail().isEmpty());
			return false;
		}
		
		try {
			Login log = vol.getLogin();
			
			
			if(!e.getEmail().equals(log.getEmail()) && !logService.emailAvailable(e.getEmail())) {
				System.out.println("blab");
				return false;
			}

			vol.setFirstName(e.getFirstName());
			vol.setLastName(e.getLastName());
			vol.setBio(e.getBio());
			log.setEmail(e.getEmail());
			
			if(e.getNewPassword() != null && !e.getNewPassword().isEmpty()) {
				if(e.getPassword().equals(e.getNewPassword())) return false;
				log.setPassword(passwordEncoder.encode(e.getNewPassword()));
				System.out.println("Sifra");
			}
			
			saveVolunteer(vol);
			logService.saveLogin(log);
			
		} catch (Exception exc) {
			exc.printStackTrace();
			System.out.println("Exc");
			return false;
		}
		
		return true;
	}

	public boolean uploadImage(UploadImage u) {
		Volunteer vol = getByIdPlain(u.getId());
		try {
			vol.setPicByte(Base64.getDecoder().decode(u.getImage()));
			saveVolunteer(vol);
		} catch(Exception e) {
			return false;
		}
		return true;
	}

}

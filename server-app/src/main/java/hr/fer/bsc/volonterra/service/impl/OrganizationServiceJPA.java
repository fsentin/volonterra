package hr.fer.bsc.volonterra.service.impl;

import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import hr.fer.bsc.volonterra.dto.EditOrganizationProfile;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.OrganizationDetails;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.model.Login;
import hr.fer.bsc.volonterra.model.Organization;
import hr.fer.bsc.volonterra.repository.OrganizationRepository;
import hr.fer.bsc.volonterra.service.OrganizationService;
/**
 * JPA implementation of the service layer for organizations.
 * @author Fani
 *
 */
@Service
public class OrganizationServiceJPA implements OrganizationService {

	@Autowired
	private OrganizationRepository repo;
	
	@Autowired
	private LoginServiceJPA logService;
	
	@Autowired
    private PasswordEncoder passwordEncoder;

	@Override
	public OrganizationDetails getById(Long id) {
		Optional<Organization> opOrg = repo.findById(id);
		if(opOrg.isEmpty()) return null;
		return new OrganizationDetails(opOrg.get());
	}
	
	@Override
	public Organization getByIdPlain(Long id) {
		Optional<Organization> opOrg = repo.findById(id);
		if(opOrg.isEmpty()) return null;
		return opOrg.get();
	}

	@Override
	public byte[] getImageById(Long id) {
		Optional<Organization> opOrg = repo.findById(id);
		if(opOrg.isEmpty()) return null;
		return opOrg.get().getPicByte();
	}
	
	@Override
	public List<OpportunityDTO> getActiveOpportunitiesById(Long id) {
		Optional<Organization> opOrg = repo.findById(id);
		if(opOrg.isEmpty()) return null;
		return opOrg.get().getActiveOpportunities().stream().map((o) -> new OpportunityDTO(o)).collect(Collectors.toList());
	}

	@Override
	@Transactional
	public void saveOrganization(Organization newOrg) {
		repo.save(newOrg);
	}

	@Override
	public boolean editProfile(EditOrganizationProfile e) {
		Organization org = getByIdPlain(e.getId());
		if(org == null) return false;
		
		if(!passwordEncoder.matches(e.getPassword(), org.getLogin().getPassword()) ||
		   e.getName().isEmpty() || 
		   e.getPassword().isEmpty() || 
		   e.getEmail().isEmpty()
		  ) {
			return false;
		}
		
		try {
			Login log = org.getLogin();
			
			
			if(!e.getEmail().equals(log.getEmail()) && !logService.emailAvailable(e.getEmail())) {
				return false;
			}

			org.setName(e.getName());
			org.setDescription(e.getDescription());
			org.setLocation(e.getLocation());
			log.setEmail(e.getEmail());
			
			if(e.getNewPassword() != null && !e.getNewPassword().isEmpty()) {
				if(e.getPassword().equals(e.getNewPassword())) return false;
				log.setPassword(passwordEncoder.encode(e.getNewPassword()));
			}
			
			saveOrganization(org);
			logService.saveLogin(log);
			
		} catch (Exception exc) {
			return false;
		}
		
		return true;
	}

	@Override
	public boolean uploadImage(UploadImage u) {
		Organization org = getByIdPlain(u.getId());
		try {
			org.setPicByte(Base64.getDecoder().decode(u.getImage()));
			saveOrganization(org);
		} catch(Exception e) {
			return false;
		}
		return true;
	}

}

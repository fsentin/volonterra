package hr.fer.bsc.volonterra.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import hr.fer.bsc.volonterra.dto.LoginResponse;
import hr.fer.bsc.volonterra.dto.OrganizationRegistration;
import hr.fer.bsc.volonterra.dto.VolunteerRegistration;
import hr.fer.bsc.volonterra.model.Organization;
import hr.fer.bsc.volonterra.model.Login;
import hr.fer.bsc.volonterra.model.Volunteer;
import hr.fer.bsc.volonterra.repository.LoginRepository;
import hr.fer.bsc.volonterra.service.LoginService;
/**
 * JPA implementation of the service layer for user login information.
 * @author Fani
 *
 */
@Service
public class LoginServiceJPA implements LoginService {
	
	@Autowired
	private VolunteerServiceJPA vService;
	
	@Autowired
	private OrganizationServiceJPA oService;
	
	@Autowired
	private LoginRepository loginRepo;
	
	@Autowired
    private PasswordEncoder passwordEncoder;
	
	@Override
	@Transactional
	public LoginResponse createVolunteer(VolunteerRegistration volunteer) {
		Assert.notNull(volunteer, "Volunteer registration object missing.");
		
		String email = volunteer.getEmail();
		String password = volunteer.getPassword();
		String hash = passwordEncoder.encode(password);
		String firstName = volunteer.getFirstName();
		String lastName = volunteer.getLastName();
		
		validateLoginInfo(email, password);
		Assert.hasText(firstName, "First name must have text.");
		Assert.hasText(lastName, "Last name must have text.");
		Assert.isTrue(emailAvailable(email), "This email is already in use.");
		
		Volunteer newVolunteer = new Volunteer(firstName, lastName, null, null);
		Login newLogin = new Login(newVolunteer, email, hash);
		
		newVolunteer.setLogin(newLogin);
		vService.saveVolunteer(newVolunteer);
		loginRepo.save(newLogin);
		
		return new LoginResponse(newVolunteer.getId(), true);
	}
	
	@Override
	@Transactional
	public LoginResponse createOrganization(OrganizationRegistration org) {
		Assert.notNull(org, "Organization registration object missing.");
		
		String email = org.getEmail();
		String password = org.getPassword();
		String hash = passwordEncoder.encode(password);
		String name = org.getName();
		
		validateLoginInfo(email, password);
		
		Assert.hasText(name, "Name must have text.");
		Assert.isTrue(emailAvailable(email), "This email is already in use.");
		
		Organization newOrg = new Organization(name, null, null);
		Login newLogin = new Login(newOrg, email, hash);
		
		newOrg.setLogin(newLogin);
		oService.saveOrganization(newOrg);
		loginRepo.save(newLogin);

		return new LoginResponse(newOrg.getId(), false);
	}
	
	@Override
	public LoginResponse login(String email, String password) {
		Optional<Login> user = loginRepo.findByEmail(email);
		if(user.isPresent()) {
			if(passwordEncoder.matches(password, user.get().getPassword())) {
				Long id = user.get().getId();
				return new LoginResponse(id, isVolunteerById(id));
			}
		} 
		return null;
	}
	
	@Override
	public LoginResponse login(String email) {
		Optional<Login> user = loginRepo.findByEmail(email);
		if(user.isPresent()) {
			Long id = user.get().getId();
			return new LoginResponse(id, isVolunteerById(id));
		} 
		return null;
	}
	
	private void validateLoginInfo(String email, String password) {
		Assert.hasText(email, "Email must have text.");
		Assert.hasText(password, "Password must have text.");
		Assert.isTrue(password.length() >= 8, "Password cannot be shorter than 8 characters.");
	}
	
	@Override
	public boolean emailAvailable(String email) {
		return !loginRepo.existsByEmail(email);
	}
	
	@Override
	public boolean isVolunteerById(Long id) {
		Optional<Login> user = loginRepo.findById(id);
		if(user.isPresent()) {
			if(user.get().getVolunteer() != null) {
				return true;
			}
		}
		return false;
	}
	
	@Override
	public void saveLogin(Login log) {
		loginRepo.save(log);
	}
}

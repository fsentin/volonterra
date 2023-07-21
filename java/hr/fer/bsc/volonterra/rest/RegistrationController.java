package hr.fer.bsc.volonterra.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hr.fer.bsc.volonterra.dto.LoginResponse;
import hr.fer.bsc.volonterra.dto.OrganizationRegistration;
import hr.fer.bsc.volonterra.dto.VolunteerRegistration;
import hr.fer.bsc.volonterra.service.LoginService;

@RestController
@RequestMapping("/registration")
public class RegistrationController {
	
	@Autowired
	private LoginService service;
	
	@PostMapping("/volunteer")
	public ResponseEntity<LoginResponse> registerVolunteer(@RequestBody VolunteerRegistration reg) {
		return ResponseEntity.ok().body(service.createVolunteer(reg));
	}
	
	@PostMapping("/organization")
	public ResponseEntity<LoginResponse> registerOrganization(@RequestBody OrganizationRegistration reg) {
		return ResponseEntity.ok().body(service.createOrganization(reg));
	}
	
}

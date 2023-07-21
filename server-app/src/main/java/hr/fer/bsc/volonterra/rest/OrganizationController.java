package hr.fer.bsc.volonterra.rest;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import hr.fer.bsc.volonterra.dto.EditOrganizationProfile;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.OrganizationDetails;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.service.OrganizationService;

@RestController
@RequestMapping("/organizations")
public class OrganizationController {
	@Autowired
	private OrganizationService service;
	
	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@GetMapping("/organization-view/{id}")
	public ResponseEntity<OrganizationDetails> getDetailsById(@PathVariable Long id) {
		OrganizationDetails org = service.getById(id);
		if(org != null) return ResponseEntity.ok().body(org);
		return ResponseEntity.badRequest().body(null);
	}

	@Secured("ROLE_VOLUNTEER")
	@GetMapping("/volunteer-view/{id}")
	public ResponseEntity<OrganizationDetails> getDetailsForVolunteerById(@PathVariable Long id) {
		OrganizationDetails org = service.getById(id);
		if(org != null) return ResponseEntity.ok().body(org);
		return ResponseEntity.badRequest().body(null);
	}
	
	@GetMapping("/active-opportunities/{id}")
	public ResponseEntity<List<OpportunityDTO>> getActiveOpportunitiesById(@PathVariable Long id) {
		var resp = service.getActiveOpportunitiesById(id);
		if(resp != null) return ResponseEntity.ok().body(resp);
		return ResponseEntity.badRequest().body(null);
	}
	
	@GetMapping("/{id}/image")
	public void getImage(@PathVariable Long id, HttpServletResponse response) {
		byte[] picBytes = service.getImageById(id);
	    try {
	    	if(picBytes != null) {
	    		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    		response.getOutputStream().write(picBytes);
	    		response.setStatus(200);
	    		response.getOutputStream().close();
	    	} else {
	    		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	    	}
		} catch (IOException e) {
		}
	}
	
	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@PostMapping("/edit/{id}")
	public ResponseEntity<Object> editOrganizationProfile(@RequestBody EditOrganizationProfile e) {
		boolean success = service.editProfile(e);
		if(success) {
			return ResponseEntity.ok().body(null);
		} else {
			return ResponseEntity.badRequest().body(null);
		}
	}
	
	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@PostMapping("/upload-image/{id}")
	public ResponseEntity<Object> editOrganizationProfilePicture(@RequestBody UploadImage u) {
		boolean success = service.uploadImage(u);
		if(success) {
			return ResponseEntity.ok().body(null);
		} else {
			return ResponseEntity.badRequest().body(null);
		}
	}

}

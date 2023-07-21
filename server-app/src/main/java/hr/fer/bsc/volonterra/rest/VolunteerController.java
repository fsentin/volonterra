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

import hr.fer.bsc.volonterra.dto.EditVolunteerProfile;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.dto.VolunteerDTO;
import hr.fer.bsc.volonterra.dto.VolunteerDetailsForOrganization;
import hr.fer.bsc.volonterra.dto.VolunteerDetailsForVolunteer;
import hr.fer.bsc.volonterra.service.VolunteerService;

@RestController
@RequestMapping("/volunteers")
public class VolunteerController {
	@Autowired
	private VolunteerService service;

	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@GetMapping("/all")
	public ResponseEntity<List<VolunteerDTO>> getAll() {
		List<VolunteerDTO> volunteer = service.getAll();
		return ResponseEntity.ok().body(volunteer);
	}
	
	@Secured("ROLE_VOLUNTEER")
	@GetMapping("/volunteer-view/{id}")
	public ResponseEntity<VolunteerDetailsForVolunteer> getDetailsByIdForVolunteer(@PathVariable Long id) {
		VolunteerDetailsForVolunteer volunteer = service.getByIdForVolunteer(id);
		if(volunteer != null) return ResponseEntity.ok().body(volunteer);
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@GetMapping("/organization-view/{id}")
	public ResponseEntity<VolunteerDetailsForOrganization> getDetailsByIdForOrganization(@PathVariable Long id) {
		VolunteerDetailsForOrganization volunteer = service.getByIdForOrganization(id);
		if(volunteer != null) return ResponseEntity.ok().body(volunteer);
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
	
	@Secured("ROLE_VOLUNTEER")
	@GetMapping("/{id}/applied")
	public ResponseEntity<List<OpportunityDTO>> getAppliedOpportunitiesForVolunteer(@PathVariable Long id) {
		List<OpportunityDTO> o = service.getAppliedOpportunities(id);
		if(o !=  null) {
			return ResponseEntity.ok().body(o);
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured("ROLE_VOLUNTEER")
	@GetMapping("/{id}/accepted")
	public ResponseEntity<List<OpportunityDTO>> getAcceptedOpportunitiesForVolunteer(@PathVariable Long id) {
		List<OpportunityDTO> o = service.getRecentAcceptedOpportunities(id);
		if(o !=  null) {
			return ResponseEntity.ok().body(o);
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured({"ROLE_VOLUNTEER", "ROLE_ADMIN"})
	@PostMapping("/edit/{id}")
	public ResponseEntity<Object> editVolunteerProfile(@RequestBody EditVolunteerProfile e) {
		boolean success = service.editProfile(e);
		if(success) {
			return ResponseEntity.ok().body(null);
		} else {
			return ResponseEntity.badRequest().body(null);
		}
	}
	
	@Secured({"ROLE_VOLUNTEER", "ROLE_ADMIN"})
	@PostMapping("/upload-image/{id}")
	public ResponseEntity<Object> editVolunteerProfilePicture(@RequestBody UploadImage u) {
		boolean success = service.uploadImage(u);
		if(success) {
			return ResponseEntity.ok().body(null);
		} else {
			return ResponseEntity.badRequest().body(null);
		}
	}

}

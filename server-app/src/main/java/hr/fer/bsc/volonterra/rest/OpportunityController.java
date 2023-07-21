package hr.fer.bsc.volonterra.rest;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import hr.fer.bsc.volonterra.dto.CreateOpportunity;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.OpportunityDetails;
import hr.fer.bsc.volonterra.dto.OpportunityDetailsForOrganization;
import hr.fer.bsc.volonterra.dto.OpportunityDetailsForVolunteer;
import hr.fer.bsc.volonterra.model.Opportunity;
import hr.fer.bsc.volonterra.model.Volunteer;
import hr.fer.bsc.volonterra.service.OpportunityService;
import hr.fer.bsc.volonterra.service.OrganizationService;
import hr.fer.bsc.volonterra.service.VolunteerService;

@RestController
@RequestMapping("/opportunities")
public class OpportunityController {
	@Autowired
	OpportunityService service;
	
	@Autowired
	VolunteerService vService;
	
	@Autowired
	OrganizationService oService;

	@Secured("ROLE_VOLUNTEER")
	@GetMapping("/{id}/volunteer/{volunteerId}")
	public ResponseEntity<OpportunityDetailsForVolunteer> getOpportunityForVolunteer(@PathVariable Long id, @PathVariable Long volunteerId) {
		OpportunityDetailsForVolunteer o = service.getByIdForVolunteer(id, volunteerId);
		if(o !=  null) {
			return ResponseEntity.ok().body(o);
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@GetMapping("/{id}")
	public ResponseEntity<OpportunityDetailsForOrganization> getOpportunityForOrganization(@PathVariable Long id) {
		OpportunityDetailsForOrganization o = service.getByIdForOrganization(id);
		if(o !=  null) {
			return ResponseEntity.ok().body(o);
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured({"ROLE_ORGANIZATION"})
	@PostMapping("/new/{orgId}")
	public ResponseEntity<Object> createOpportunity(@PathVariable Long orgId, @RequestBody CreateOpportunity dto) {
		if(oService.getByIdPlain(orgId) == null) {
			return ResponseEntity.badRequest().body(null);
		}
		Long id = service.createOpportunity(orgId, dto);
		Opportunity op = service.getByIdPlain(id);
		if(op != null) {
			return ResponseEntity.ok().body(null);
		} else {
			return ResponseEntity.status(500).body(null);
		}
	}
	
	@Secured({"ROLE_ORGANIZATION", "ROLE_ADMIN"})
	@PostMapping("/deactivate/{id}/{orgId}")
	public ResponseEntity<Object> deactivateOpportunity(@PathVariable Long id,  @PathVariable Long orgId) {
		service.deactivate(id, orgId);
		Opportunity o = service.getByIdPlain(id);
		if(o !=  null) {
			if(!o.isActive()) {
				return ResponseEntity.ok().body(null);
			} else {
				return ResponseEntity.status(500).body(null);
			}
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured("ROLE_ORGANIZATION")
	@PostMapping("/{id}/accept/{volunteerId}")
	public ResponseEntity<Object> acceptVolunteerToOpportunity(@PathVariable Long id, @PathVariable Long volunteerId) {
		service.acceptVolunteerToOpportunity(id, volunteerId);
		Opportunity o = service.getByIdPlain(id);
		if(o != null) {
			Volunteer v = vService.getByIdPlain(volunteerId);
			if(o.getAcceptedVolunteers().contains(v)) {
				return ResponseEntity.ok().body(null);
			} else {
				return ResponseEntity.status(500).body(null);
			}
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@Secured("ROLE_ORGANIZATION")
	@PostMapping("/{id}/decline/{volunteerId}")
	public ResponseEntity<Object> removeAcceptedVolunteerFromOpportunity(@PathVariable Long id, @PathVariable Long volunteerId) {
		service.removeAcceptedVolunteerFromOpportunity(id, volunteerId);
		Opportunity o = service.getByIdPlain(id);
		if(o != null) {
			Volunteer v = vService.getByIdPlain(volunteerId);
			if(!o.getAcceptedVolunteers().contains(v)) {
				return ResponseEntity.ok().body(null);
			} else {
				return ResponseEntity.status(500).body(null);
			}
		}
		return ResponseEntity.badRequest().body(null);
	}

	@Secured({"ROLE_ADMIN", "ROLE_VOLUNTEER"})
	@GetMapping("/retrieve")
	public ResponseEntity<List<OpportunityDTO>> getTags(@RequestParam(value="search") Optional<String> searchEntry) {
		if(searchEntry.isEmpty() || searchEntry.get().isBlank()) return ResponseEntity.ok().body(service.getAll());
		return ResponseEntity.ok().body(service.getSearch(searchEntry.get()));
	}
	
	@Secured({"ROLE_VOLUNTEER",  "ROLE_ADMIN"})
	@PostMapping("/{id}/apply/{volunteerId}")
	public ResponseEntity<Object> applyVolunteerToOpportunity(@PathVariable Long id, @PathVariable Long volunteerId) {
		service.applyVolunteerToOpportunity(id, volunteerId);
		Opportunity o = service.getByIdPlain(id);
		if(o != null) {
			Volunteer v = vService.getByIdPlain(volunteerId);
			if(o.getAppliedVolunteers().contains(v)) {
				return ResponseEntity.ok().body(null);
			} else {
				return ResponseEntity.status(500).body(null);
			}
		}
		return ResponseEntity.badRequest().body(null);
	}

	@Secured({"ROLE_VOLUNTEER",  "ROLE_ADMIN"})
	@PostMapping("/{id}/quit/{volunteerId}")
	public ResponseEntity<Object> removeVolunteerApplicationToOpportunity(@PathVariable Long id, @PathVariable Long volunteerId) {
		service.removeVolunteerApplicationFromOpportunity(id, volunteerId);
		Opportunity o = service.getByIdPlain(id);
		if(o != null) {
			Volunteer v = vService.getByIdPlain(volunteerId);
			if(!o.getAppliedVolunteers().contains(v)) {
				return ResponseEntity.ok().body(null);
			} else {
				return ResponseEntity.status(500).body(null);
			}
		}
		return ResponseEntity.badRequest().body(null);
	}
	
	@GetMapping("/{id}/image")
	public void getImage(@PathVariable Long id, HttpServletResponse response) {
		byte[] picBytes = service.getImageById(id);
	    try {
	    	response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    	if(picBytes != null) {
	    		response.getOutputStream().write(picBytes);
	    		response.setStatus(200);
	    	} else {
	    		response.setStatus(404);
	    	}
	    	response.getOutputStream().close();
		} catch (IOException e) {
		}
	}
	
}

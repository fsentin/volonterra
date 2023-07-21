package hr.fer.bsc.volonterra.rest;

import java.io.IOException;
import java.util.Base64;
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

import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.TagDTO;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.service.TagService;

@RestController
@RequestMapping("/tags")
public class TagController {
	@Autowired
	TagService service;
	
	@GetMapping("/all")
	public ResponseEntity<List<TagDTO>> getTags() {
		return ResponseEntity.ok().body(service.getAll());
	}
	
	@Secured({"ROLE_VOLUNTEER",  "ROLE_ADMIN"})
	@GetMapping("/{id}")
	public ResponseEntity<List<OpportunityDTO>> getOpportunitiesTagged(@PathVariable Long id) {
		 return ResponseEntity.ok().body(service.getAllTaggedOpportunities(id));
	}

	@GetMapping("/image/{id}")
	public void getImage(@PathVariable Long id, HttpServletResponse response) {
		byte[] image = service.getImage(id);
	    try {
	    	if(image != null) {
	    		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    		response.getOutputStream().write(image);
	    		response.setStatus(200);
	    		response.getOutputStream().close();
	    	} else {
	    		response.sendError(HttpServletResponse.SC_NOT_FOUND);
	    	}
		} catch (IOException e) {
		}
	}
	

	@Secured("ROLE_ADMIN")
	@PostMapping("/image/{name}")
	public ResponseEntity<Object> uploadImageToTag(@RequestBody UploadImage u) {
		try {
			if(service.addImageToTag(u.getId(), Base64.getDecoder().decode(u.getImage()))) {
				return ResponseEntity.ok().body(null);
			}
		} catch (Exception e) {
			return ResponseEntity.status(500).body(null);
		}		
		return ResponseEntity.badRequest().body(null);
	}

	@Secured("ROLE_ADMIN")
	@PostMapping("/new/{name}")
	public ResponseEntity<Object> createTag(@PathVariable String name) {
		if(service.createNewTag(name) != null) {
			return ResponseEntity.ok().body(null);
		}
		return ResponseEntity.badRequest().body(null);
	}

	@Secured("ROLE_ADMIN")
	@PostMapping("/delete/{name}")
	public ResponseEntity<Object> deleteTag(@PathVariable Long id) {
		if(service.deleteTag(id)) {
			return ResponseEntity.ok().body(null);
		}
		return ResponseEntity.badRequest().body(null);
	}
	
}

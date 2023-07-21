package hr.fer.bsc.volonterra.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import hr.fer.bsc.volonterra.dto.Login;
import hr.fer.bsc.volonterra.dto.LoginResponse;
import hr.fer.bsc.volonterra.service.LoginService;

@RestController
public class LoginController {
	
	@Autowired
	private LoginService service;
	
	@PostMapping("/login")
	public ResponseEntity<LoginResponse> login(@RequestBody Login log) {
		LoginResponse response = service.login(log.getEmail(), log.getPassword());
		if(log.getEmail().equals("admin@volonterra.hr"))  return ResponseEntity.ok().body(null);
		if(response != null) return ResponseEntity.ok().body(response);
		
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
	}
	
}

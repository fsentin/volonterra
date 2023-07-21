package hr.fer.bsc.volonterra.rest.security;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import hr.fer.bsc.volonterra.model.Login;
import hr.fer.bsc.volonterra.repository.LoginRepository;

/**
 * This class offers association of the login details with authentication details.
 * @author Fani
 *
 */
@Component("volonterraUserDetailsService")
public class VolonterraUserDetailsService implements UserDetailsService {
	
	@Value("${admin.password}")
    private String adminPasswordHash;

	@Autowired
    private LoginRepository loginRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
    	if (email.equals("admin@volonterra.hr")) { 
            return new User(email, adminPasswordHash,
                    AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_ADMIN"));
        }
    	Optional<Login> login = loginRepository.findByEmail(email);
        if (login.isPresent()) {
        	if(login.get().isVolunteer()) {
            return new User(email, login.get().getPassword(),
                    AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_VOLUNTEER"));
        	} else {
        		return new User(email, login.get().getPassword(),
                        AuthorityUtils.commaSeparatedStringToAuthorityList("ROLE_ORGANIZATION"));
        	}
        }
        throw new UsernameNotFoundException("Username " + email + " not found");
    }

}


package hr.fer.bsc.volonterra.rest.security;

import javax.annotation.Resource;

import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
/**
 * This class configures security of the server application.
 * @author Fani
 *
 */
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class WebSecurity extends WebSecurityConfigurerAdapter {

	 @Resource(name = "volonterraUserDetailsService")
     private VolonterraUserDetailsService volonterraUserDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http.httpBasic().and().cors();
        http.sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        http.authorizeRequests()
                .antMatchers(  "/registration/**",
                			   "/login/**",
                			   "/tags/image/**"
                			   ).permitAll()
                .requestMatchers(req-> req.getRequestURI().contains("image") && req.getRequestURI().contains("volunteers")).permitAll()
                .requestMatchers(req-> req.getRequestURI().contains("image") && req.getRequestURI().contains("organizations")).permitAll()
                .requestMatchers(req-> req.getRequestURI().contains("image") && req.getRequestURI().contains("opportunities")).permitAll()
                .anyRequest().authenticated()
                //.and()
                //.addFilter(new AuthenticationFilter(authenticationManager()))
                //.addFilter(new AuthorizationFilter(authenticationManager()))
                ;
        http.csrf().disable();
        http.headers().frameOptions().sameOrigin();

    }
    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(volonterraUserDetailsService);
    }

}

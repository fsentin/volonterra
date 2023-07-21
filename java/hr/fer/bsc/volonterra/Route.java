package hr.fer.bsc.volonterra;

import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

/**
 * Class containing static field representing dynamically determined base route.
 * @author Fani
 *
 */
public class Route {
	/** Static field representing dynamically determined base route i.e. works both local and remote. **/
	public static final String BASEROUTE = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
}

package hr.fer.bsc.volonterra.service;

import hr.fer.bsc.volonterra.dto.LoginResponse;
import hr.fer.bsc.volonterra.dto.OrganizationRegistration;
import hr.fer.bsc.volonterra.dto.VolunteerRegistration;
import hr.fer.bsc.volonterra.model.Login;

/**
 * Interface containing business logic of the user login information required for the server application.
 * @author Fani
 *
 */
public interface LoginService {
	/**
	 * Checks if a given email is available i.e. if a user with such email already exists.
	 * @param email the email which is checked for availability
	 * @return true if the given email is available, false otherwise.
	 */
	public boolean emailAvailable(String email);
	
	/**
	 * Creates a new user of type volunteer with given registration information.
	 * @param volunteer registration information of the new volunteer
	 * @return object containing id and type of the new user.
	 */
	public LoginResponse createVolunteer(VolunteerRegistration volunteer);
	
	/**
	 * Creates a new user of type organization with given registration information.
	 * @param volunteer registration information of the new organization
	 * @return object containing id and type of the new user.
	 */
	public LoginResponse createOrganization(OrganizationRegistration org);
	
	/**
	 * Checks if the given login information is valid.
	 * @param email email of the user trying to access the system
	 * @param password password of the user trying to access the system
	 * @return object containing identificator and type of the user, null if entered login information is invalid.
	 */
	public LoginResponse login(String email, String password);
	
	/**
	 * Checks if a user with given identificator is a volunteer.
	 * @param id user identificator whose type is determined
	 * @return true if the type of the user with the given identificator is volunteer, false otherwise.
	 */
	public boolean isVolunteerById(Long id);
	
	/**
	 * Perserves any changes made to the login information.
	 * @param log login object
	 */
	public void saveLogin(Login log);

	LoginResponse login(String email);
}

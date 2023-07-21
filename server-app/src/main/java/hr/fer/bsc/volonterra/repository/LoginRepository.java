package hr.fer.bsc.volonterra.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import hr.fer.bsc.volonterra.model.Login;
/**
 * Acts as the layer closest to database for user login information.
 * @author Fani
 *
 */
public interface LoginRepository extends JpaRepository<Login, Long>{
	/**
	 * Checks if a user with given email already exists in the system.
	 * @param email the email which is checked if is already in use
	 * @return true if user with given email already exists, false otherwise.
	 */
	boolean existsByEmail(String email);
	
	/**
	 * Searches the system for a user with given email.
	 * @param email the email of which the owner is wanted
	 * @return optional login information of the user with given email.
	 */
	Optional<Login> findByEmail(String email);
	
}

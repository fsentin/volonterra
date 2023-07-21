package hr.fer.bsc.volonterra.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import hr.fer.bsc.volonterra.model.Opportunity;
/**
 * Acts as the layer closest to database for volunteering opportunites.
 * @author Fani
 *
 */
public interface OpportunityRepository extends JpaRepository<Opportunity, Long> {
	
	/**
	 * Retrieves all volunteering opportunities available in the system.
	 * @return list containing all opportunities.
	 */
	List<Opportunity> findAll();
	
	/**
	 * Searches the system for opportunites which have the given name.
	 * @param name name of the opportunities which are wanted
	 * @return set of opportunites with a given name.
	 */
	Set<Opportunity> findByName(String name);
	
	/**
	 * Searches the system for opportunites which have the given location.
	 * @param location location of the opportunities which are wanted
	 * @return set of opportunites with a given location.
	 */
	Set<Opportunity> findByLocation(String location);

}

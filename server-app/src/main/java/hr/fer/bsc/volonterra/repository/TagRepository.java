package hr.fer.bsc.volonterra.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import hr.fer.bsc.volonterra.model.Tag;
/**
 * Acts as the layer closest to database for tags.
 * @author Fani
 *
 */
public interface TagRepository extends JpaRepository<Tag, Long>{
	/**
	 * Searches the system for a tag with the given name.
	 * @param name name of the tag which is wanted
	 * @return optional tag which holds the given name.
	 */
	Optional<Tag> findByName(String name);
	
	/**
	 * Retrieves all tags available in the system.
	 * @return all tags available in the system.
	 */
	List<Tag> findAll();

}

package hr.fer.bsc.volonterra.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import hr.fer.bsc.volonterra.model.Volunteer;
/**
 * Acts as the layer closest to database for volunteers.
 * @author Fani
 *
 */
public interface VolunteerRepository extends JpaRepository<Volunteer, Long> {

}

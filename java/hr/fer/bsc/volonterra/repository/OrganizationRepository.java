package hr.fer.bsc.volonterra.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import hr.fer.bsc.volonterra.model.Organization;
/**
 * Acts as the layer closest to database for organizations.
 * @author Fani
 *
 */
public interface OrganizationRepository extends JpaRepository<Organization, Long> {

}

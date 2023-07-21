package hr.fer.bsc.volonterra.service;

import java.util.List;

import hr.fer.bsc.volonterra.dto.EditVolunteerProfile;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.dto.VolunteerDTO;
import hr.fer.bsc.volonterra.dto.VolunteerDetailsForOrganization;
import hr.fer.bsc.volonterra.dto.VolunteerDetailsForVolunteer;
import hr.fer.bsc.volonterra.model.Volunteer;
/**
 * Interface containing business logic of the volunteers required for the server application.
 * @author Fani
 *
 */
public interface VolunteerService {
	/**
	 * Retrieves all volunteers avaliable in the system.
	 * @return all volunteers avaliable in the system.
	 */
	public List<VolunteerDTO> getAll();
	
	/**
	 * Retrieves details of a volunteer with the given identificator for organizations.
	 * @param id identificator of the volunteer whose details are retrieved
	 * @return object containing details about the volunteer,
	 *  null if there is no such opportunity or no such volunteer
	 */
	public VolunteerDetailsForOrganization getByIdForOrganization(Long id);
	
	/**
	 * Retrieves personal details of a volunteer with the given identificator.
	 * @param id identificator of the volunteer whose details are retrieved
	 * @return object containing details about the volunteer,
	 *  null if there is no such opportunity or no such volunteer
	 */
	public VolunteerDetailsForVolunteer getByIdForVolunteer(Long id);
	
	/**
	 * Retrieves the volunteer which has the given identificator.
	 * @param id identificator of the volunteer which is retrieved
	 * @return volunteer entity object, null if there is no volunteer with such identificator.
	 */
	public Volunteer getByIdPlain(Long id);
	
	/**
	 * Retrieves image of the volunteer with the specified identificator.
	 * @param id identificator of the volunteer whose the image is retrieved
	 * @return byte array representing the image of the volunteer.
	 */
	public byte[] getImageById(Long id);
	
	/**
	 * Perserves any changes made to the volunteer.
	 * @param v volunteer entity object
	 */
	public void saveVolunteer(Volunteer v);
	
	/**
	 * Retrieves opportunities for which the volunteer with specified identificator has been chosen.
	 * @param id identificator of the volunteer whose recently successful applications are retrieved
	 * @return opportunities for which the volunteer has recently been chosen, null if there is no volunteer with given identificator.
	 */
	public List<OpportunityDTO> getRecentAcceptedOpportunities(Long id);
	
	/**
	 * Retrieves opportunities for which the volunteer with specified identificator has applied.
	 * @param id identificator of the volunteer whose applications are retrieved
	 * @return opportunities for which the volunteer has applied, null if there is no volunteer with given identificator.
	 */
	public List<OpportunityDTO> getAppliedOpportunities(Long id);
	
	/**
	 * Edits personal information of a volunteer.
	 * @param e information which is changed
	 * @return true if editing successful, false otherwise.
	 */
	public boolean editProfile(EditVolunteerProfile e);
	
	/**
	 * Sets the image of the volunteer to the picture represented by given byte array.
	 * @param u object containing the volunteer identificator and byte array representing the picture
	 * @return true if image successfully set, false otherwise.
	 */
	public boolean uploadImage(UploadImage u);
	
}

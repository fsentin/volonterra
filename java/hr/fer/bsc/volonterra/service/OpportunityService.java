package hr.fer.bsc.volonterra.service;

import java.util.List;

import hr.fer.bsc.volonterra.dto.CreateOpportunity;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.OpportunityDetails;
import hr.fer.bsc.volonterra.dto.OpportunityDetailsForOrganization;
import hr.fer.bsc.volonterra.dto.OpportunityDetailsForVolunteer;
import hr.fer.bsc.volonterra.model.Opportunity;

/**
 * Interface containing business logic of the volunteering opportunities required for the server application.
 * @author Fani
 *
 */
public interface OpportunityService {
	/**
	 * Retrieves all volunteering opportunities available in the system.
	 * @return all volunteering opportunities available in the system.
	 */
	public List<OpportunityDTO> getAll();
	
	/**
	 * Retrieves details of an opportunity with the given identificator 
	 * personalized for the volunteer with the given volunteer identificator.
	 * @param id identificator of the opportunity of which the details are retrieved
	 * @param volunteerId identificator of the volunteer for which the opportunity details are retrieved
	 * @return object containing details about the volunteering opportunity including personalized information of volunteer,
	 *  null if there is no such opportunity or no such volunteer
	 * 
	 */
	public OpportunityDetailsForVolunteer getByIdForVolunteer(Long id, Long volunteerId);
	
	/**
	 * Retrieves opportunity details with the given identificator for public purposes.
	 * @param id identificator of the opportunity of which the details are retrieved
	 * @return object containing details about the volunteering opportunity, null if there is no such opportunity 
	 */
	public OpportunityDetails getByIdPublic(Long id);
	
	/**
	 * Retrieves opportunity details of an opportunity with the given identificator 
	 * personalized for the owner organization with the given organization identificator.
	 * @param id identificator of the opportunity of which the details are retrieved
	 * @return object containing details about the volunteering opportunity including applied volunteers,
	 *  null if there is no such opportunity 
	 */
	public OpportunityDetailsForOrganization getByIdForOrganization(Long id);
	
	/**
	 * Retrieves the opportunity which has the given identificator.
	 * @param id identificator of the opportunity of which is retrieved
	 * @return opportunity entity object, null if there is no opportunity with such identificator.
	 */
	public Opportunity getByIdPlain(Long id);
	
	/**
	 * Retrieves image of the opportunity with the specified id.
	 * @param id identificator of the opportunity of which the image is retrieved
	 * @return byte array representing the image of the opportunity.
	 */
	public byte[] getImageById(Long id);
	
	/**
	 * Retrieves all opportunities which contain the given keyword.
	 * @param searchEntry string which is searched as a keyword against opportunities to find matches
	 * @return all opportunities that match the given string.
	 */
	public List<OpportunityDTO> getSearch(String searchEntry);
	
	/**
	 * Creates a new opportunity for the owner organization of the given organization identificator.
	 * @param orgId identificator of the owner organization
	 * @param odto information for the newly created opportunity 
	 * @return identificator of the newly created opportunity, null if unsuccesful.
	 */
	public Long createOpportunity(Long orgId, CreateOpportunity odto);
	
	/**
	 * Applies the volunteer with the given identificator to the opportunity with the specified identificator.
	 * @param id idenitificator of the opportunity for which a volunteer is applied
	 * @param volunteerId identificator of the volunteer which is applied to the opportunity
	 */
	public void applyVolunteerToOpportunity(Long id, Long volunteerId);
	
	/**
	 * Cancels application of the volunteer with the given identificator from the opportunity with the specified identificator.
	 * @param id idenitificator of the opportunity from which a volunteer's application is removed
	 * @param volunteerId  identificator of the volunteer whose application to opportunity is canceled.
	 */
	public void removeVolunteerApplicationFromOpportunity(Long id, Long volunteerId);
	
	/**
	 * Adds volunteer with the specified identificator to list of chosen volunteers for the opportunity with a specified identificator.
	 * @param id idenitificator of the opportunity for which a volunteer is accepted
	 * @param volunteerId identificator of the volunteer which is accepted for the opportunity
	 */
	public void acceptVolunteerToOpportunity(Long id, Long volunteerId);
	
	/**
	 * Removes volunteer with the specified identificator from list of chosen volunteers for the opportunity with a specified identificator.
	 * @param id idenitificator of the opportunity from which a volunteer is removed
	 * @param volunteerId identificator of the volunteer which is removed from the opportunity
	 */
	public void removeAcceptedVolunteerFromOpportunity(Long id, Long volunteerId);
	
	/**
	 * Makes the opportunity with the specified identificator inactive meaning that volunteers no longer can apply to it.
	 * @param id idenitificator of the opportunity which is deactivated
	 * @param orgId idenitificator of the owner organization
	 */
	public void deactivate(Long id, Long orgId);
	
	/**
	 * Adds a tag of the given identificator to an opportunity with the given opportunity identificator.
	 * @param opId identificator of the opportunity to which the tag is added
	 * @param tagId identificator of the tag which is added to the opportunity
	 */
	public void addTag(Long opId, Long tagId);
	
	/**
	 * Sets the image of the opportunity with the given identificator to the picture represented by given byte array.
	 * @param opId identificator of the opportunity of which the image is set
	 * @param picByte byte array representing the image of the opportunity
	 */
	public void addImage(Long opId, byte[] picByte);
}

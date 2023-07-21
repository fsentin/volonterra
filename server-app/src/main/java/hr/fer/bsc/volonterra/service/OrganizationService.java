package hr.fer.bsc.volonterra.service;

import java.util.List;

import hr.fer.bsc.volonterra.dto.EditOrganizationProfile;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.OrganizationDetails;
import hr.fer.bsc.volonterra.dto.UploadImage;
import hr.fer.bsc.volonterra.model.Organization;
/**
 * Interface containing business logic of the organizations required for the server application.
 * @author Fani
 *
 */
public interface OrganizationService {

	/**
	 * Retrieves details of an organization with the given identificator.
	 * @param id identificator of the organization whose details are retrieved
	 * @return object containing details about the organization,
	 *  null if there is no organization.
	 */
	public OrganizationDetails getById(Long id);
	
	/**
	 * Retrieves the organization which has the given identificator.
	 * @param id identificator of the organization which is retrieved
	 * @return organization entity object, null if there is no organization with such identificator.
	 */
	public Organization getByIdPlain(Long id);
	
	/**
	 * Retrieves image of the organization with the specified identificator.
	 * @param id identificator of the organization whose the image is retrieved
	 * @return byte array representing the image of the organization.
	 */
	public byte[] getImageById(Long id);
	
	/**
	 * Retrieves active opportunities of the organization with the specified identificator.
	 * @param id identificator of the organization whose active opportunities are retrieved
	 * @return ctive opportunities of the organization with the specified identificator.
	 */
	public List<OpportunityDTO> getActiveOpportunitiesById(Long id);
	
	/**
	 * Perserves any changes made to the organization.
	 * @param o organization entity object
	 */
	public void saveOrganization(Organization o);
	
	/**
	 * Edits personal information of the organization.
	 * @param e information which is changed
	 * @return true if editing successful, false otherwise.
	 */
	public boolean editProfile(EditOrganizationProfile e);
	
	/**
	 * Sets the image of the organization to the picture represented by given byte array.
	 * @param u object containing the organization identificator and byte array representing the picture
	 * @return true if image successfully set, false otherwise.
	 */
	public boolean uploadImage(UploadImage u);
}

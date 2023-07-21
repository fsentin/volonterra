package hr.fer.bsc.volonterra.service;

import java.util.List;

import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.TagDTO;
import hr.fer.bsc.volonterra.model.Tag;
/**
 * Interface containing business logic of the tags required for the server application.
 * @author Fani
 *
 */
public interface TagService {
	
	/**
	 * Retrieves the tag which has the given identificator.
	 * @param id identificator of the tag which is retrieved
	 * @return tag entity object, null if there is no tag with such identificator.
	 */
	public Tag getByIdPlain(Long id);
	
	/**
	 * Retrieves all tags available in the system.
	 * @return all tags available in the system.
	 */
	public List<TagDTO> getAll();
	
	/**
	 * Retrieves all opportunities which are tagged with the tag whose identificator is specified.
	 * @param id identificator of the tag with which are tagged opportunites that are retrieved
	 * @return ll opportunities which are tagged with the tag whose identificator is specified.
	 */
	public List<OpportunityDTO> getAllTaggedOpportunities(Long id);
	public byte[] getImage(Long id);
	public boolean addImageToTag(Long id, byte[] picByte);
	
	/**
	 * Creates a new tag with the given name
	 * @param name name of the newly created tag
	 * @return identificator of the newly created tag, null if unsuccesful.
	 */
	public Long createNewTag(String name);
	
	/**
	 * Deletes the tag specified by the identificator.
	 * @param id identificator of the tag which is deleted
	 */
	public boolean deleteTag(Long id);
	
	/**
	 * Perserves any changes made to the tag.
	 * @param t tag entity object
	 */
	public void saveTag(Tag t);
}

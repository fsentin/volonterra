package hr.fer.bsc.volonterra.service.impl;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.TagDTO;
import hr.fer.bsc.volonterra.model.Tag;
import hr.fer.bsc.volonterra.repository.TagRepository;
import hr.fer.bsc.volonterra.service.TagService;
/**
 * JPA implementation of the service layer for tags.
 * @author Fani
 *
 */
@Service
public class TagServiceJPA implements TagService {
	@Autowired
	private TagRepository repo;
	
	@Override
	public Tag getByIdPlain(Long id) {
		Optional<Tag> opTag =  repo.findById(id);
		if(opTag.isEmpty()) return null;
		return opTag.get();
	}
	
	@Override
	public List<TagDTO> getAll() {
		return repo.findAll().stream()
				.map((tag) -> new TagDTO(tag))
				.collect(Collectors.toList());
	}
	
	@Override
	public List<OpportunityDTO> getAllTaggedOpportunities(Long id) {
		List<OpportunityDTO> result = new LinkedList<>();
		Optional<Tag> opTag = repo.findById(id);
		if(opTag.isEmpty()) return result;
		
		return opTag.get().getTaggedOpportunities().stream().filter((o) -> o.isActive())
		.map((op) -> new OpportunityDTO(op))
		.collect(Collectors.toList());
	}
	
	@Override
	public byte[] getImage(Long id) {
		Tag tag = getByIdPlain(id);
		if(tag == null) return null;
		
		return tag.getPicByte();
	}
	
	@Override
	public boolean addImageToTag(Long id, byte[] picByte) {
		Optional<Tag> opTag = repo.findById(id);
		if(opTag.isEmpty()) return false;
		
		opTag.get().setPicByte(picByte);
		repo.save(opTag.get());
		return true;
	}
	
	@Override
	public Long createNewTag(String name) {
		Optional<Tag> opTag = repo.findByName(name);
		if(opTag.isPresent()) return null;
		
		Tag tag = new Tag(name, null);
		repo.save(tag);
		return tag.getId();
	}
	
	@Override
	public boolean deleteTag(Long id) {
		Optional<Tag> opTag = repo.findById(id);
		if(opTag.isEmpty()) return false;
		
		repo.delete(opTag.get());
		return true;
	}
	
	@Override
	public void saveTag(Tag t) {
		repo.save(t);
	}
}

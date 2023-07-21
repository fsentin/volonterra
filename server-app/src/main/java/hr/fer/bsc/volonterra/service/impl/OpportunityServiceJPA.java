package hr.fer.bsc.volonterra.service.impl;

import java.sql.Date;
import java.util.Base64;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import hr.fer.bsc.volonterra.dto.CreateOpportunity;
import hr.fer.bsc.volonterra.dto.OpportunityDTO;
import hr.fer.bsc.volonterra.dto.OpportunityDetails;
import hr.fer.bsc.volonterra.dto.OpportunityDetailsForOrganization;
import hr.fer.bsc.volonterra.dto.OpportunityDetailsForVolunteer;
import hr.fer.bsc.volonterra.model.Opportunity;
import hr.fer.bsc.volonterra.model.Organization;
import hr.fer.bsc.volonterra.model.Tag;
import hr.fer.bsc.volonterra.model.Volunteer;
import hr.fer.bsc.volonterra.repository.OpportunityRepository;
import hr.fer.bsc.volonterra.service.OpportunityService;
/**
 * JPA implementation of the service layer for volunteering opportunities.
 * @author Fani
 *
 */
@Service
public class OpportunityServiceJPA implements OpportunityService {
	
	@Autowired
	private OpportunityRepository repo;
	
	@Autowired
	private VolunteerServiceJPA vService;
	
	@Autowired
	private OrganizationServiceJPA oService;
	
	@Autowired
	private TagServiceJPA tService;
	
	@Override
	public List<OpportunityDTO> getAll() {
		return repo.findAll().stream()
				.map((op) -> new OpportunityDTO(op))
				.collect(Collectors.toList());
	}
	
	@Override
	public OpportunityDetailsForVolunteer getByIdForVolunteer(Long id, Long volunteerId) {
		Optional<Opportunity> op =  repo.findById(id);
		if(op.isEmpty()) return null;

		Volunteer opv =  vService.getByIdPlain(volunteerId);
		if(opv == null) return null;
		return new OpportunityDetailsForVolunteer(op.get(), opv);
	}
	
	@Override
	public OpportunityDetails getByIdPublic(Long id) {
		Optional<Opportunity> op =  repo.findById(id);
		if(op.isEmpty()) return null;
		return new OpportunityDetails(op.get());
	}
	
	@Override
	public OpportunityDetailsForOrganization getByIdForOrganization(Long id) {
		Optional<Opportunity> op =  repo.findById(id);
		if(op.isEmpty()) return null;

		return new OpportunityDetailsForOrganization(op.get(), op.get().getOrganization());
	}
	
	@Override
	public Opportunity getByIdPlain(Long id) {
		Optional<Opportunity> op =  repo.findById(id);
		if(op.isEmpty()) return null;
		return op.get();
	}
	
	@Override
	public byte[] getImageById(Long id) {
		Optional<Opportunity> op = repo.findById(id);
		if(op.isEmpty()) return null;
		
		return op.get().getPicByte();
	}
	
	@Override
	public List<OpportunityDTO> getSearch(String searchEntry) {
		if(searchEntry.isEmpty()) return getAll();
		Set<Opportunity> results = new HashSet<>();
		results.addAll(repo.findByName(searchEntry));
		results.addAll(repo.findByLocation(searchEntry));
		return results.stream().filter((o) -> o.isActive())
				.map((op) -> new OpportunityDTO(op))
				.collect(Collectors.toList());
	}
	
	@Override
	public Long createOpportunity(Long orgId, CreateOpportunity odto) {
		Organization org = oService.getByIdPlain(orgId);
		if(org == null) return null;
		
		Assert.hasText(odto.getName(), "Name must have text.");
		Assert.hasText(odto.getLocation(), "Location name must have text.");
		Opportunity o = new Opportunity(org,
				odto.getName(),
				odto.getLocation(),
				odto.getDescription(),
				odto.getImage() == null ? null : Base64.getDecoder().decode(odto.getImage()),
				odto.getRequirements(), 
				Date.valueOf(odto.getStart()),
				Date.valueOf(odto.getEnd())
				);
		
		repo.save(o);
		if(odto.getTags() != null) {
			for(Long tagId : odto.getTags()) {
				addTag(o.getId(), tagId);
			}
		}
		return o.getId();
	}
	
	@Override
	@Transactional
	public void applyVolunteerToOpportunity(Long id, Long volunteerId) {
		Opportunity op = getByIdPlain(id);
		Volunteer v = vService.getByIdPlain(volunteerId);
		if(op == null || v == null) return;
		op.addAppliedVolunteer(v);
		v.addAppliedOpportunity(op);
		repo.save(op);
		vService.saveVolunteer(v);
	}
	
	@Override
	@Transactional
	public void removeVolunteerApplicationFromOpportunity(Long id, Long volunteerId) {
		Opportunity op = getByIdPlain(id);
		Volunteer v = vService.getByIdPlain(volunteerId);
		if(op == null || v == null) return;
		op.removeAppliedVolunteer(v);
		v.removeAppliedOpportunity(op);
		repo.save(op);
		vService.saveVolunteer(v);
	}
	
	@Override
	@Transactional
	public void acceptVolunteerToOpportunity(Long id, Long volunteerId) {
		Opportunity op = getByIdPlain(id);
		Volunteer v = vService.getByIdPlain(volunteerId);
		if(op == null || v == null || v.getAcceptedOpportunities().contains(op)) return;
		op.addAcceptedVolunteer(v);
		op.removeAppliedVolunteer(v);
		v.removeAppliedOpportunity(op);
		v.addAcceptedOpportunity(op);
		repo.save(op);
		vService.saveVolunteer(v);
	}
	
	@Override
	@Transactional
	public void removeAcceptedVolunteerFromOpportunity(Long id, Long volunteerId) {
		Opportunity op = getByIdPlain(id);
		Volunteer v = vService.getByIdPlain(volunteerId);
		if(op == null || v == null) return;
		op.removeAcceptedVolunteer(v);
		v.removeAcceptedOpportunity(op);
		op.addAppliedVolunteer(v);
		v.addAppliedOpportunity(op);
		repo.save(op);
		vService.saveVolunteer(v);
	}
	
	@Override
	public void deactivate(Long id, Long orgId) {
		Opportunity op = getByIdPlain(id);
		if(op.getOrganization().getId().equals(orgId)) {
			op.setActive(false);
			op.setAppliedVolunteers(new LinkedList<Volunteer>());
			repo.save(op);
		}
	}
	
	@Override
	@Transactional
	public void addTag(Long opId, Long tagId) {
		Opportunity op = this.getByIdPlain(opId);
		Tag tag = tService.getByIdPlain(tagId);
		if(op != null || tag != null) {
			op.addTag(tag);
			tag.add(op);
			repo.save(op);
			tService.saveTag(tag);
		}
	}
	
	@Override
	public void addImage(Long opId, byte[] picByte) {
		Opportunity op = this.getByIdPlain(opId);
		if(op != null) {
			op.setPicByte(picByte);
			repo.save(op);
		}
	}
}

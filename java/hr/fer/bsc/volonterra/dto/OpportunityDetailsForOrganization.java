package hr.fer.bsc.volonterra.dto;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import hr.fer.bsc.volonterra.Route;
import hr.fer.bsc.volonterra.model.Opportunity;
import hr.fer.bsc.volonterra.model.Organization;

public class OpportunityDetailsForOrganization {
	private Long id;
	private String name;
	private Long organizationId;
	private String organizationName;
	private String imageRoute;
	
	private String location;
	private String description;
	private String requirements;
	private Date startDate;
	private Date endDate;
	private List<TagDTO> tags;
	
	private boolean active;
	
	private List<VolunteerDTO> appliedVolunteers; 
	private List<VolunteerDTO> acceptedVolunteers; 
	
	public OpportunityDetailsForOrganization(Opportunity o, Organization org) {
		this.id = o.getId();
		this.name = o.getName();
		this.organizationId = o.getOrganization().getId();
		this.organizationName = o.getOrganization().getName();
		
		this.location = o.getLocation();
		this.description = o.getDescription();
		this.startDate = o.getStartDate();
		this.endDate = o.getEndDate();
		this.requirements = o.getRequirements();
		this.imageRoute =   Route.BASEROUTE + "/opportunities/" + o.getId() + "/image";
		this.tags = o.getTags().stream().map((tag) -> new TagDTO(tag)).collect(Collectors.toList());
		this.active = o.isActive();
		this.appliedVolunteers = o.getAppliedVolunteers().stream().map((v) -> new VolunteerDTO(v)).collect(Collectors.toList());
		this.acceptedVolunteers = o.getAcceptedVolunteers().stream().map((v) -> new VolunteerDTO(v)).collect(Collectors.toList());
	}


	public boolean getActive() {
		return active;
	}


	public void setActive(boolean active) {
		this.active = active;
	}


	public List<VolunteerDTO> getAppliedVolunteers() {
		return appliedVolunteers;
	}


	public void setAppliedVolunteers(List<VolunteerDTO> appliedVolunteers) {
		this.appliedVolunteers = appliedVolunteers;
	}


	public List<VolunteerDTO> getAcceptedVolunteers() {
		return acceptedVolunteers;
	}


	public void setAcceptedVolunteers(List<VolunteerDTO> acceptedVolunteers) {
		this.acceptedVolunteers = acceptedVolunteers;
	}


	public String getImageRoute() {
		return imageRoute;
	}

	public void setImageRoute(String imageRoute) {
		this.imageRoute = imageRoute;
	}

	public String getRequirements() {
		return requirements;
	}

	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}

	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public Long getOrganizationId() {
		return organizationId;
	}


	public void setOrganizationId(Long organizationId) {
		this.organizationId = organizationId;
	}


	public String getOrganizationName() {
		return organizationName;
	}


	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Date getStartDate() {
		return startDate;
	}


	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}


	public Date getEndDate() {
		return endDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public List<TagDTO> getTags() {
		return tags;
	}

	public void setTags(List<TagDTO> tags) {
		this.tags = tags;
	}

}


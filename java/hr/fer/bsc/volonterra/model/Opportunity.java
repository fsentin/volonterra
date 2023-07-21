package hr.fer.bsc.volonterra.model;

import java.sql.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
//import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * This class represents volunteering activities which are created by organizations and applied to by volunteers.
 * @author Fani
 *
 */
@Entity
public class Opportunity {
	
	/**
	 * Identificator of the volunteering opportunity.
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long opportunityId;
	
	/**
	 * Organization which is organizing the volunteering opportunity.
	 */
	@ManyToOne
    @JoinColumn(name="organization_id", nullable=false)
	private Organization organization;
	
	/**
	 * Name of the position or activity which the volunteer is performing if he gets accepted to opportunity.
	 */
	@NotBlank
	private String name;
	
	/**
	 * Location at which the volunteering opportunity is performed.
	 */
	@NotBlank
	private String location;
	
	/**
	 * Detailed description of a volunteering opportunity.
	 */
	private String description;
	
	/**
	 * Picture of opportunity stored in a byte array format.
	 */
	@Column(length = 100000000)
	private byte[] picByte;
	
	/**
	 * Tools, skills or personality traits required for a volunteer to get accepted.
	 */
	private String requirements;
	
	/**
	 * Categories which explain the area of work in which the volunteering opportunity belongs.
	 */
	@ManyToMany(mappedBy = "taggedOpportunities")
	private Set<Tag> tags;
	
	/**
	 * Beginning date of the volunteering opportunity.
	 */
	@NotNull
	private Date startDate;
	
	/**
	 * Ending date of the volunteering opportunity.
	 */
	@NotNull
	private Date endDate;
	
	/**
	 * Volunteer which have applied for the volunteering opportunity.
	 */
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "applied_volunteers",
	joinColumns = { @JoinColumn(name = "volunteer_id")},
	inverseJoinColumns = { @JoinColumn(name = "opportunity_id")})
	private List<Volunteer> appliedVolunteers;
	
	/**
	 * Volunteers which have been accepted for the volunteering opportunity.
	 */
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "accepted_volunteers",
	joinColumns = { @JoinColumn(name = "volunteer_id")},
	inverseJoinColumns = { @JoinColumn(name = "opportunity_id")})
	private List<Volunteer> acceptedVolunteers;
	
	/**
	 * Represents if the volunteering opportunity is active i.e. open for applications by volunteers.
	 */
	private boolean active = true;


	public Opportunity() {
		
	}
	
	public Opportunity(Organization organization, @NotBlank String name, @NotBlank String location, String description,
			byte[] picByte, String requirements, @NotNull Date startDate, @NotNull Date endDate) {
		super();
		this.organization = organization;
		this.name = name;
		this.location = location;
		this.description = description;
		this.picByte = picByte;
		this.requirements = requirements;
		this.startDate = startDate;
		this.endDate = endDate;
		this.tags = new HashSet<Tag>();
		this.acceptedVolunteers = new LinkedList<Volunteer>();
		this.appliedVolunteers = new LinkedList<Volunteer>();
		
	}
	
	public Long getId() {
		return opportunityId;
	}
	
	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getRequirements() {
		return requirements;
	}

	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}
	
	public void addTag(Tag t) {
		this.tags.add(t);
	}
	
	public void removeTag(Tag t) {
		this.tags.remove(t);
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

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public List<Volunteer> getAppliedVolunteers() {
		return appliedVolunteers;
	}
	
	public void addAppliedVolunteer(Volunteer v) {
		this.appliedVolunteers.add(v);
	}
	
	public void removeAppliedVolunteer(Volunteer v) {
		this.appliedVolunteers.remove(v);
	}

	public void setAppliedVolunteers(List<Volunteer> appliedVolunteers) {
		this.appliedVolunteers = appliedVolunteers;
	}


	public List<Volunteer> getAcceptedVolunteers() {
		return acceptedVolunteers;
	}
	
	public void addAcceptedVolunteer(Volunteer v) {
		this.acceptedVolunteers.add(v);
	}
	
	public void removeAcceptedVolunteer(Volunteer v) {
		this.acceptedVolunteers.remove(v);
	}

	public void setAcceptedVolunteers(List<Volunteer> acceptedVolunteers) {
		this.acceptedVolunteers = acceptedVolunteers;
	}

	public byte[] getPicByte() {
		return picByte;
	}

	public void setPicByte(byte[] picByte) {
		this.picByte = picByte;
	}

	public Set<Tag> getTags() {
		return tags;
	}

	public void setTags(Set<Tag> tags) {
		this.tags = tags;
	}

	@Override
	public String toString() {
		return "Opportunity [opportunityId=" + opportunityId + ", organization=" + organization + ", name=" + name
				+ ", active=" + active + "]";
	}

}

package hr.fer.bsc.volonterra.model;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * This class represents organizations which offer volunteering opportunites to volunteers.
 * @author Fani
 *
 */
@Entity
public class Organization {
	/**
	 * Identificator of the organization (in user context).
	 */
	@Id
	private Long id;
	
	/**
	 * Login information of the organization.
	 */
	@OneToOne
    @MapsId
	private Login login;
	
	/**
	 * Volunteering opportunites which this organization offers.
	 */
	@OneToMany(mappedBy="organization")
	private List<Opportunity> opportunities;
	
	/**
	 * Official name of the organization.
	 */
	@NotBlank
	private String name;
	
	/**
	 * Description of organization and its goals.
	 */
	private String description;
	
	/**
	 * Location of the organization.
	 */
	private String location;
	
	/**
	 * Picture of organization stored in a byte array format.
	 */
	@Column(length = 100000000)
	private byte[] picByte;
	
	public Organization() {
	}

	public Organization(@Size(min = 1) String name, String description, String location) {
		this.name = name;
		this.description = description;
		this.location = location;
		this.opportunities = new LinkedList<Opportunity>();
	}
	
	public Long getId() {
		return id;
	}

	public List<Opportunity> getOpportunities() {
		return opportunities;
	}
	
	public List<Opportunity> getActiveOpportunities() {
		return opportunities.stream().filter((o) -> o.isActive()).collect(Collectors.toList());
	}
	
	public List<Opportunity> getPastOpportunities() {
		return opportunities.stream().filter((o) -> !o.isActive()).collect(Collectors.toList());
	}
	
	public Opportunity getOpportunityById(Long id) {
		for(Opportunity o :this.opportunities) {
			if(o.getId().equals(id)) return o;
		}
		return null;
	}

	public void setOpportunities(List<Opportunity> opportunities) {
		this.opportunities = opportunities;
	}
	
	public void addOpportunity(Opportunity opp) {
		this.opportunities.add(opp);
	}
	
	public void removeOpportunity(Opportunity opp) {
		this.opportunities.remove(opp);
	}

	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public byte[] getPicByte() {
		return picByte;
	}

	public void setPicByte(byte[] picByte) {
		this.picByte = picByte;
	}

	@Override
	public String toString() {
		return "Organization [id=" + id + ", name=" + name + ", description="
				+ description + ", location=" + location + "]";
	}
	
}

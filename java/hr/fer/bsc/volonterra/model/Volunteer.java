package hr.fer.bsc.volonterra.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
public class Volunteer {
	/**
	 * Identificator of the voluteer (in user context).
	 */
	@Id
	private Long id;
	
	/**
	 * Login information of the volunteer.
	 */
	@OneToOne
    @MapsId
	private Login login;
	
	/**
	 * First name of the volunteer.
	 */
	@NotBlank
	private String firstName;
	
	/**
	 * Last name of the volunteer.
	 */
	@NotBlank
	private String lastName;
	
	/**
	 * Biographical information about the volunteer.
	 */
	private String bio;
	
	/**
	 * Picture of volunteer stored in a byte array format.
	 */
	@Column(length = 100000000)
	private byte[] picByte;
	
	/**
	 * Opportunities for which the volunteer has applied.
	 */
	@ManyToMany(mappedBy = "appliedVolunteers")
	private List<Opportunity> appliedOpportunities;
	
	/**
	 * Opportunities for which the volunteer has been accepted.
	 */
	@ManyToMany(mappedBy = "acceptedVolunteers")
	private List<Opportunity> acceptedOpportunities;
	
	public Volunteer() {
	}

	public Volunteer(@NotNull @Size(min = 1) String firstName, @NotNull @Size(min = 1) String lastName,
			String bio, byte[] picByte) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.bio = bio;
		this.picByte = picByte;
	}

	public Long getId() {
		return id;
	}

	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(@NotNull @Size(min = 1) String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(@NotNull @Size(min = 1) String lastName) {
		this.lastName = lastName;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public byte[] getPicByte() {
		return picByte;
	}

	public void setPicByte(byte[] picByte) {
		this.picByte = picByte;
	}
	
	public void addAppliedOpportunity(Opportunity op) {
		this.appliedOpportunities.add(op);
	}
	
	public void addAcceptedOpportunity(Opportunity op) {
		this.acceptedOpportunities.add(op);
	}
	
	public void removeAppliedOpportunity(Opportunity op) {
		this.appliedOpportunities.remove(op);
	}
	
	public void removeAcceptedOpportunity(Opportunity op) {
		this.acceptedOpportunities.remove(op);
	}

	public List<Opportunity> getAppliedOpportunities() {
		return appliedOpportunities;
	}

	public void setAppliedOpportunities(List<Opportunity> appliedOpportunities) {
		this.appliedOpportunities = appliedOpportunities;
	}

	public List<Opportunity> getAcceptedOpportunities() {
		return acceptedOpportunities;
	}

	public void setAcceptedOpportunities(List<Opportunity> acceptedOpportunities) {
		this.acceptedOpportunities = acceptedOpportunities;
	}

	@Override
	public String toString() {
		return "Volunteer [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", bio=" + bio + "]";
	}

}

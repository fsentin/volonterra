package hr.fer.bsc.volonterra.dto;

import java.util.List;
import java.util.stream.Collectors;

import hr.fer.bsc.volonterra.Route;
import hr.fer.bsc.volonterra.model.Volunteer;

public class VolunteerDetailsForOrganization {

	private Long id;
	private String firstName;
	private String lastName;
	private String email;
	private String bio;
	private String imageRoute;
	private List<OpportunityDTO> past;
	
	public VolunteerDetailsForOrganization(Volunteer v) {
		this.id = v.getId();
		this.firstName = v.getFirstName();
		this.lastName = v.getLastName();
		this.email = v.getLogin().getEmail();
		this.bio = v.getBio();
		this.imageRoute = Route.BASEROUTE + "/volunteers/" + v.getId() + "/image";
		this.setPast(v.getAcceptedOpportunities().stream()
				.filter((o) -> !o.isActive())
				.map((o) -> new OpportunityDTO(o))
				.collect(Collectors.toList()));
	}
	
	public VolunteerDetailsForOrganization(Long id, String firstName, String lastName, String email, String bio, String imageRoute) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.bio = bio;
		this.imageRoute = imageRoute;
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
	}

	public String getImageRoute() {
		return imageRoute;
	}

	public void setImageRoute(String imageRoute) {
		this.imageRoute = imageRoute;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<OpportunityDTO> getPast() {
		return past;
	}

	public void setPast(List<OpportunityDTO> past) {
		this.past = past;
	}

}

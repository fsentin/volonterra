package hr.fer.bsc.volonterra.dto;

import java.util.List;
import java.util.stream.Collectors;

import hr.fer.bsc.volonterra.Route;
import hr.fer.bsc.volonterra.model.Organization;

public class OrganizationDetails {

	private Long id;
	private String name;
	private String email;
	private String description;
	private String location;
	private String imageRoute;
	private List<OpportunityDTO> active;
	private List<OpportunityDTO> past;
	
	public OrganizationDetails(Organization o) {
		this.id = o.getId();
		this.name = o.getName();
		this.email = o.getLogin().getEmail();
		this.description = o.getDescription();
		this.location = o.getLocation();
		this.imageRoute =  Route.BASEROUTE + "/organizations/" + o.getId() + "/image";
		this.active = o.getActiveOpportunities().stream().map((op) -> new OpportunityDTO(op)).collect(Collectors.toList());
		this.past = o.getPastOpportunities().stream().map((op) -> new OpportunityDTO(op)).collect(Collectors.toList());
	}
	
	public OrganizationDetails(Long id, String name, String email, String description, String location,
			String imageRoute) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.description = description;
		this.location = location;
		this.imageRoute = imageRoute;
	}
	
	
	public List<OpportunityDTO> getActive() {
		return active;
	}

	public void setActive(List<OpportunityDTO> active) {
		this.active = active;
	}

	public List<OpportunityDTO> getPast() {
		return past;
	}

	public void setPast(List<OpportunityDTO> past) {
		this.past = past;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getImageRoute() {
		return imageRoute;
	}
	public void setImageRoute(String imageRoute) {
		this.imageRoute = imageRoute;
	}

}

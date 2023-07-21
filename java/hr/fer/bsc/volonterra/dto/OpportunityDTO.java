package hr.fer.bsc.volonterra.dto;

import hr.fer.bsc.volonterra.Route;
import hr.fer.bsc.volonterra.model.Opportunity;

public class OpportunityDTO {
	private Long id;
	private String name;
	private String organizationName;
	private String location;
	private String imageRoute;
	
	public OpportunityDTO(Long id, String name, String organizationName, String location, String imageRoute) {
		super();
		this.id = id;
		this.name = name;
		this.organizationName = organizationName;
		this.location = location;
		this.imageRoute = imageRoute;
	}
	
	public OpportunityDTO(Opportunity o) {
		this.id = o.getId();
		this.name = o.getName();
		this.organizationName = o.getOrganization().getName();
		this.location = o.getLocation();
		this.imageRoute =  Route.BASEROUTE + "/opportunities/" + o.getId() + "/image";
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

	public String getImageRoute() {
		return imageRoute;
	}

	public void setImageRoute(String imageRoute) {
		this.imageRoute = imageRoute;
	}
	
}

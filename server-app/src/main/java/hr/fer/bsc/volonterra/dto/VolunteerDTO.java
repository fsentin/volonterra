package hr.fer.bsc.volonterra.dto;

import hr.fer.bsc.volonterra.Route;
import hr.fer.bsc.volonterra.model.Volunteer;

public class VolunteerDTO {
	private Long id;
	private String firstName;
	private String lastName;
	private String imageRoute;
	
	public VolunteerDTO(Volunteer v) {
		super();
		this.id = v.getId();
		this.firstName = v.getFirstName();
		this.lastName = v.getLastName();
		this.imageRoute =  Route.BASEROUTE + "/volunteers/" + this.id + "/image";
	}
	
	public VolunteerDTO(Long id, String firstName, String lastName) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.imageRoute =  Route.BASEROUTE + "/volunteers/" + this.id + "/image";
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
	public String getImageRoute() {
		return imageRoute;
	}
	public void setImageRoute(String imageRoute) {
		this.imageRoute = imageRoute;
	}

}

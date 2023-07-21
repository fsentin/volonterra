package hr.fer.bsc.volonterra.dto;

import hr.fer.bsc.volonterra.model.Tag;
import hr.fer.bsc.volonterra.Route;

public class TagDTO {
	private Long id;
	private String name;
	private String route;
	
	public TagDTO(Long id, String name, String route) {
		super();
		this.id = id;
		this.name = name;
		this.route = route;
	}
	
	
	public TagDTO(Tag tag) {
		this.id = tag.getId();
		this.name = tag.getName();
		this.route = Route.BASEROUTE + "/tags/image/" + tag.getId();
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
	public String getRoute() {
		return route;
	}
	public void setRoute(String route) {
		this.route = route;
	}
	
	@Override
	public String toString() {
		return "TagDTO [name=" + name + ", route=" + route + "]";
	}
	
}

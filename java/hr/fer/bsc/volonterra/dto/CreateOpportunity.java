package hr.fer.bsc.volonterra.dto;

import java.util.List;

public class CreateOpportunity {
	private String name;
	
	private String location;
	private String description;
	private String requirements;
	private String start;
	private String end;
	private String image;
	private List<Long> tags;
	
	public CreateOpportunity(String name, String location, String description,
			String requirements, String startDate, String endDate, String image, List<Long> tags) {
		super();
		this.name = name;
		this.location = location;
		this.description = description;
		this.requirements = requirements;
		this.start = startDate;
		this.end = endDate;
		this.setImage(image);
		this.setTags(tags);
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


	public String getStart() {
		return start;
	}


	public void setStart(String start) {
		this.start = start;
	}


	public String getEnd() {
		return end;
	}


	public void setEnd(String end) {
		this.end = end;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public List<Long> getTags() {
		return tags;
	}


	public void setTags(List<Long> tags) {
		this.tags = tags;
	}
	

}

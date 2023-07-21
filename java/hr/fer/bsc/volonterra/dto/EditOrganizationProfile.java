package hr.fer.bsc.volonterra.dto;

public class EditOrganizationProfile {
	private Long id;
	private String name;
	private String email;
	private String description;
	private String location;
	private String password;
	private String newPassword;
	
	public EditOrganizationProfile(Long id, String name, String email, String description, String location,
			String password, String newPassword) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.description = description;
		this.location = location;
		this.password = password;
		this.newPassword = newPassword;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
}

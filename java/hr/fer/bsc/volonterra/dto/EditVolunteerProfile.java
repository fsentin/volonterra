package hr.fer.bsc.volonterra.dto;

public class EditVolunteerProfile {
	private Long id;
	private String firstName;
	private String lastName;
	private String email;
	private String bio;
	private String password;
	private String newPassword;
	
	public EditVolunteerProfile(Long id, String firstName, String lastName, String email, String bio, String password,
			String newPassword) {
		super();
		this.setId(id);
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.bio = bio;
		this.password = password;
		this.newPassword = newPassword;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}

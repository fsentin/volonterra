package hr.fer.bsc.volonterra.dto;


public class LoginResponse {
	private Long id;
	private boolean volunteer;
	
	public LoginResponse(Long id, boolean isVolunteer) {
		super();
		this.id = id;
		this.volunteer = isVolunteer;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public boolean getVolunteer() {
		return volunteer;
	}

	public void setVolunteer(boolean volunteer) {
		this.volunteer = volunteer;
	}
	
}

package hr.fer.bsc.volonterra.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * This class represents each user's login information. 
 * @author Fani
 *
 */
@Entity
public class Login {
	
	/**
	 * Identificator of the user.
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	/**
	 * Field which is filled if a user is of organization type.
	 */
	@OneToOne(mappedBy="login", cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
	private Organization organization;
	
	/**
	 * Field which is filled if a user is of volunteer type.
	 */
	@OneToOne(mappedBy="login", cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
	private Volunteer volunteer;
	
	/**
	 * Email of the user.
	 */
	@NotNull
	@Email
	@Column(unique = true)
	@Size(min = 3, max = 320)
	private String email;
	
	/**
	 * Password hash of the user.
	 */
	@NotNull
	private String password;
	
	
	public Login() {
	}

	public Login(Organization organization, @NotNull @Email @Size(min = 3, max = 320) String email,
			@NotNull String password) {
		super();
		this.organization = organization;
		this.email = email;
		this.password = password;
	}

	public Login(Volunteer volunteer, @NotNull @Email @Size(min = 3, max = 320) String email, String password) {
		super();
		this.volunteer = volunteer;
		this.email = email;
		this.password = password;
	}
	

	public Long getId() {
		return id;
	}

	public Volunteer getVolunteer() {
		return volunteer;
	}

	public void setVolunteer(Volunteer volunteer) {
		this.volunteer = volunteer;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(@NotNull @Email @Size(min = 3, max = 320) String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(@NotNull String password) {
		this.password = password;
	}

	public boolean isVolunteer() {
		return this.volunteer != null;
	}
	
}

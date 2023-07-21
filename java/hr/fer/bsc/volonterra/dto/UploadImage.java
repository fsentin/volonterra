package hr.fer.bsc.volonterra.dto;

public class UploadImage {
	private Long id;
	private String image;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public UploadImage(Long id, String image) {
		super();
		this.id = id;
		this.image = image;
	}

}

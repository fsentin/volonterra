package hr.fer.bsc.volonterra.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

/**
 * This class represents categories which describe volunteering opportunities in more detail.
 * @author Fani
 *
 */
@Entity
public class Tag {
	/**
	 * Identificator of the tag.
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long tagId;

	/**
	 * Name of the tag.
	 */
	@Column(name = "name", unique = true)
	private String name;
	
	/**
	 * Opportunities which belong to category represented by the tag.
	 */
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "opportunity_tag",
	joinColumns = { @JoinColumn(name = "tag_id")},
	inverseJoinColumns = { @JoinColumn(name = "opportunity_id")})
	private Set<Opportunity> taggedOpportunities;
	
	/**
	 * Picture of tag stored in a byte array format.
	 */
	@Column(name = "picByte", length = 1000000)
	private byte[] picByte;
	
	public Tag() {
	}

	public Tag(String name, byte[] picByte) {
		super();
		this.name = name;
		this.taggedOpportunities = new HashSet<Opportunity>();
		this.picByte = picByte;
	}

	public Set<Opportunity> getTaggedOpportunities() {
		return taggedOpportunities;
	}

	public void setTaggedOpportunities(Set<Opportunity> taggedOpportunities) {
		this.taggedOpportunities = taggedOpportunities;
	}
	
	public void add(Opportunity o) {
		this.taggedOpportunities.add(o);
	}
	public void remove(Opportunity o) {
		this.taggedOpportunities.remove(o);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public byte[] getPicByte() {
		return picByte;
	}

	public void setPicByte(byte[] picByte) {
		this.picByte = picByte;
	}

	public Long getId() {
		return tagId;
	}

	@Override
	public String toString() {
		return "Tag [name=" + name + "]";
	}

}

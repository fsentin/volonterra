package hr.fer.bsc.volonterra.dto;

import java.util.List;

public class OrganizationOpportunities {
	private List<OpportunityDTO> activeOpportunities;
	private List<OpportunityDTO> pastOpportunities;
	
	public OrganizationOpportunities(List<OpportunityDTO> activeOpportunities, List<OpportunityDTO> pastOpportunities) {
		super();
		this.activeOpportunities = activeOpportunities;
		this.pastOpportunities = pastOpportunities;
	}
	
	public List<OpportunityDTO> getActiveOpportunities() {
		return activeOpportunities;
	}
	public void setActiveOpportunities(List<OpportunityDTO> activeOpportunities) {
		this.activeOpportunities = activeOpportunities;
	}
	public List<OpportunityDTO> getPastOpportunities() {
		return pastOpportunities;
	}
	public void setPastOpportunities(List<OpportunityDTO> pastOpportunities) {
		this.pastOpportunities = pastOpportunities;
	}
	
	

}

package hr.fer.bsc.volonterra;

import java.io.InputStream;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import hr.fer.bsc.volonterra.dto.CreateOpportunity;
import hr.fer.bsc.volonterra.dto.OrganizationRegistration;
import hr.fer.bsc.volonterra.dto.VolunteerRegistration;
import hr.fer.bsc.volonterra.service.impl.LoginServiceJPA;
import hr.fer.bsc.volonterra.service.impl.OpportunityServiceJPA;
import hr.fer.bsc.volonterra.service.impl.TagServiceJPA;

@SpringBootApplication
public class VolonterraApplication implements CommandLineRunner {
	
	@Autowired
	private LoginServiceJPA loginService;
	
	@Autowired
	private TagServiceJPA tagService;
	
	@Autowired 
	private OpportunityServiceJPA oppService;
	
	@Bean
	public PasswordEncoder pswdEncoder(){
		return new BCryptPasswordEncoder();
	}
	
	public static void main(String[] args) {
		SpringApplication.run(VolonterraApplication.class, args);
	}
	
	@Transactional
	@Override
	public void run(String... args) throws Exception {
		
		/* VOLUNTEERS */
		VolunteerRegistration v1 = new VolunteerRegistration("bojan@vol.hr", "12345678", "Bojan", "Horvat");
		VolunteerRegistration v2 = new VolunteerRegistration("ivana@vol.hr", "12345678", "Ivana", "Novak");
		VolunteerRegistration v3 = new VolunteerRegistration("fani@vol.hr", "12345678", "Fani", "Sentinella-Jerbić");
		VolunteerRegistration v4 = new VolunteerRegistration("goran@vol.hr", "12345678", "Goran", "Moran");
		VolunteerRegistration v5 = new VolunteerRegistration("ivan@vol.hr", "12345678", "Ivan", "Jelić");
		VolunteerRegistration v6 = new VolunteerRegistration("matea@vol.hr", "12345678", "Matea", "Korlić");
		VolunteerRegistration v7 = new VolunteerRegistration("sara@vol.hr", "12345678", "Sara", "Doro");
		loginService.createVolunteer(v1);
		loginService.createVolunteer(v2);
		loginService.createVolunteer(v3);
		loginService.createVolunteer(v4);
		loginService.createVolunteer(v5);
		loginService.createVolunteer(v6);
		loginService.createVolunteer(v7);
		/* ORGANIZATIONS */
		OrganizationRegistration org1 = new OrganizationRegistration("green@org.hr", "12345678", "Green angels");
		Long orgID1 = loginService.createOrganization(org1).getId();
		
		OrganizationRegistration org2 = new OrganizationRegistration("civil@org.hr", "12345678", "Civil Engineer Society");
		Long orgID2 = loginService.createOrganization(org2).getId();
		
		OrganizationRegistration org3 = new OrganizationRegistration("psy@org.hr", "12345678", "Psychology International");
		Long orgID3 = loginService.createOrganization(org3).getId();
		
		OrganizationRegistration org4 = new OrganizationRegistration("inclu@org.hr", "12345678", "IncluCity");
		Long orgID4 = loginService.createOrganization(org4).getId();

		OrganizationRegistration org5 = new OrganizationRegistration("doggo@org.hr", "12345678", "DogGO");
		Long orgID5 = loginService.createOrganization(org5).getId();
		
		OrganizationRegistration org6 = new OrganizationRegistration("pharma@org.hr", "12345678", "PharmaStudent");
		Long orgID6 = loginService.createOrganization(org6).getId();
		
		
		/* TAGS */
		InputStream imgInput = new ClassPathResource("photos/health.png").getInputStream();
		Long tagID1 = tagService.createNewTag("Health");
		tagService.addImageToTag(tagID1, imgInput.readAllBytes());
		
		InputStream imgInput2 =  new ClassPathResource("photos/education.png").getInputStream();
		Long tagID2 =  tagService.createNewTag("Education");
		tagService.addImageToTag(tagID2, imgInput2.readAllBytes());
		
		InputStream imgInput3 = new ClassPathResource("photos/tech.png").getInputStream();
		Long tagID3 = tagService.createNewTag("Tech support");
		tagService.addImageToTag(tagID3, imgInput3.readAllBytes());
		
		InputStream imgInput4 = new ClassPathResource("photos/crisis.png").getInputStream();
		Long tagID4 =  tagService.createNewTag("Crisis relief");
		tagService.addImageToTag(tagID4, imgInput4.readAllBytes());
		
		InputStream imgInput5 = new ClassPathResource("photos/environment.png").getInputStream();
		Long tagID5 = tagService.createNewTag("Environment");
		tagService.addImageToTag(tagID5, imgInput5.readAllBytes());
		
		InputStream imgInput6 = new ClassPathResource("photos/animal.png").getInputStream();
		Long tagID6 = tagService.createNewTag("Animal rescue");
		tagService.addImageToTag(tagID6, imgInput6.readAllBytes());
		
		/* OPPORTUNITIES */
		Long oppID1 = oppService.createOpportunity(orgID1,new CreateOpportunity("Climate Justice Volunteer", 
				"Zagreb", 
				"Participate in peaceful protests for climate justice!"
				+ " Our world is getting hotter but our politicians are getting lazier!"
				+ " We demand action! Help us neutralize human impact on Earth!",
				"Good will and activist spirit.", 
				"2021-11-15","2021-11-18", null, null));
		oppService.addTag(oppID1, tagID5);
		oppService.addImage(oppID1, new ClassPathResource("photos/climate.jpg").getInputStream().readAllBytes());
		
		Long oppID2 = oppService.createOpportunity(orgID1,new CreateOpportunity("Helper in City Gardening", 
				"Zagreb", 
				"This Saturday we are organizing a plantation of baby cypress in our local park.\n"
				+ "Come and help our city get greener!",
				"Working shoes and gardening gloves.", 
				"2021-11-15","2021-11-18", null, null));
		oppService.addTag(oppID2, tagID5);
		oppService.addImage(oppID2, new ClassPathResource("photos/gardening.jpg").getInputStream().readAllBytes());
		
		Long oppID3 = oppService.createOpportunity(orgID2,new CreateOpportunity("Earthquake Aftermath Helper",
				"Zagreb", 
				"Help remove damage from old buildings struck by big earthquake.",
				"Physical strength.", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID3, tagID4);
		oppService.addImage(oppID3, new ClassPathResource("photos/earthquake.jpg").getInputStream().readAllBytes());
		
		Long oppID = oppService.createOpportunity(orgID2,new CreateOpportunity("Web Developer",
				"Zagreb", 
				"Help us make our Civil Engineer Societywebsite.",
				"IT knowledge, developing web pages.", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID, tagID3);
		oppService.addImage(oppID, new ClassPathResource("photos/develop.jpg").getInputStream().readAllBytes());
		
		Long oppID4 = oppService.createOpportunity(orgID3,new CreateOpportunity("Mental Health Hotline Worker",
				"Zagreb", 
				"Answer calls and give real time advice to mental health issues.",
				"Psychology background.", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID4, tagID1);
		oppService.addImage(oppID4, new ClassPathResource("photos/hotline.jpg").getInputStream().readAllBytes());
		
		Long oppID5 = oppService.createOpportunity(orgID3,new CreateOpportunity("Crisis Hotline Worker",
				"Zagreb", 
				"Answer emergency calls and give immediate help to people in mental health crisis such as self harm.",
				"Psychology background.", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID5, tagID4);
		oppService.addTag(oppID5, tagID1);
		oppService.addImage(oppID5, new ClassPathResource("photos/mental.jpg").getInputStream().readAllBytes());
		
		Long oppID6 = oppService.createOpportunity(orgID4,new CreateOpportunity("Homeless Helper",
				"Zagreb", 
				"Prepare food for the homeless in our local public kitchen.",
				"Basic cooking skills, no prejudices and an inlusive mindset :)", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID6, tagID1);
		oppService.addImage(oppID6, new ClassPathResource("photos/cooking.jpg").getInputStream().readAllBytes());
		
		Long oppID7 = oppService.createOpportunity(orgID4,new CreateOpportunity("Elderly Helper",
				"Zagreb", 
				"Help elder citizens buy groceries, visit hospitals or do chores. Be their companion as well as helper.",
				 "No prejudices and an inlusive mindset", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID7, tagID1);
		oppService.addImage(oppID7, new ClassPathResource("photos/elder.jpg").getInputStream().readAllBytes());
		
		Long oppID8 = oppService.createOpportunity(orgID4,new CreateOpportunity("Instructor for Children with Special Needs",
				"Zagreb", 
				"Help children with special needs study for school.",
				"Previous experience with helping children with diabilities, , no prejudices and an inlusive mindset :)", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID8, tagID2);
		oppService.addImage(oppID8, new ClassPathResource("photos/math.jpg").getInputStream().readAllBytes());
		
		Long oppID9 = oppService.createOpportunity(orgID4,new CreateOpportunity("Course Instructor",
				"Zagreb", 
				"Teach refugees and migrants digital literacy. ",
				"Basic knowledge about computers and English literacy, no prejudices and an inlusive mindset :)", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID9, tagID2);
		oppService.addImage(oppID9, new ClassPathResource("photos/digital.jpg").getInputStream().readAllBytes());
		
		Long oppID10 = oppService.createOpportunity(orgID5,new CreateOpportunity("Dog Walker",
				"Zagreb", 
				"Walk our dogs. They spend all day in one room - give them the gift of outdoors.",
				"Patience and care for dogs.", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID10, tagID6);
		oppService.addImage(oppID10, new ClassPathResource("photos/dog.jpg").getInputStream().readAllBytes());
		
		Long oppID11 = oppService.createOpportunity(orgID6,new CreateOpportunity("Workshop Volunteer",
				"Zagreb", 
				"Help us organize our annual workhop for pharmacy students.",
				"You must currently be a pharmacy student. ", 
				"2021-11-15", "2021-11-18", null, null));
		oppService.addTag(oppID11, tagID2);
		oppService.addImage(oppID11, new ClassPathResource("photos/pills.jpg").getInputStream().readAllBytes());
		
	}

}

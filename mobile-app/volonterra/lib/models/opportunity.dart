import 'package:volonterra/models/tag.dart';
import 'package:volonterra/models/volunteer.dart';
class Opportunity {
  int id;
  String name;
  String organizationName;
  String location;
  String imageURL;

  Opportunity({this.id, this.name, this.organizationName, this.location,
    this.imageURL});

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'],
      name: json['name'],
      organizationName: json['organizationName'],
      location: json['location'],
      imageURL: json['imageRoute'],
    );
  }
}

class OpportunitiesList {
  final List<Opportunity> opportunities;

  OpportunitiesList({
    this.opportunities,
  });

  factory OpportunitiesList.fromJson(List<dynamic> json) {

    List<Opportunity> opportunities = new List<Opportunity>();
    opportunities = json.map((i) => Opportunity.fromJson(i)).toList();

    return new OpportunitiesList(
      opportunities: opportunities,
    );
  }
}

class OpportunityDetailsForVolunteer {
  int id;
  int organizationId;
  String name;
  String organizationName;
  String location;
  String imageURL;
  String startDate;
  String endDate;
  String description;
  String requirements;
  List<Tag> tags;

  bool hasApplied;

  OpportunityDetailsForVolunteer({this.id, this.organizationId, this.name,
    this.organizationName, this.location, this.imageURL, this.startDate,
    this.endDate, this.description, this.requirements, this.tags, this.hasApplied});

  factory OpportunityDetailsForVolunteer.fromJson(Map<String, dynamic> json) {
    var list = json['tags'] as List;
    return OpportunityDetailsForVolunteer(
        id: json['id'],
        organizationId: json['organizationId'],
        name: json['name'],
        organizationName: json['organizationName'],
        location: json['location'],
        imageURL: json['imageRoute'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        description: json['description'],
        requirements: json['requirements'],
        tags: list.map((i) => Tag.fromJson(i)).toList(),
        hasApplied: json['hasApplied']
    );
  }
}

class OpportunityDetailsForOrganization {
  int id;
  int organizationId;
  String name;
  String organizationName;
  String location;
  String imageURL;
  String startDate;
  String endDate;
  String description;
  String requirements;
  List<Tag> tags;

  bool isActive;
  List<Volunteer> acceptedVolunteers;
  List<Volunteer> appliedVolunteers;

  OpportunityDetailsForOrganization({this.id, this.organizationId, this.name,
    this.organizationName, this.location, this.imageURL, this.startDate,
    this.endDate, this.description, this.requirements, this.tags, this.isActive,
  this.acceptedVolunteers, this.appliedVolunteers});

  factory OpportunityDetailsForOrganization.fromJson(Map<String, dynamic> json) {
    var list = json['tags'] as List;
    var list2 = json['appliedVolunteers'] as List;
    var list3 = json['acceptedVolunteers'] as List;
    return OpportunityDetailsForOrganization(
        id: json['id'],
        organizationId: json['organizationId'],
        name: json['name'],
        organizationName: json['organizationName'],
        location: json['location'],
        imageURL: json['imageRoute'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        description: json['description'],
        requirements: json['requirements'],
        tags: list.map((i) => Tag.fromJson(i)).toList(),
        isActive: json['active'],
        acceptedVolunteers: list3.map((v) => Volunteer.fromJson(v)).toList(),
        appliedVolunteers: list2.map((v) => Volunteer.fromJson(v)).toList(),
    );
  }
}


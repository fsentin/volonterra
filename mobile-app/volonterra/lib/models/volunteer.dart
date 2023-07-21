import 'package:volonterra/models/opportunity.dart';

class VolunteerDetailsForVolunteer {
  int id;
  String firstName;
  String lastName;
  String email;
  String bio;
  String imageURL;
  List<Opportunity> past;

  VolunteerDetailsForVolunteer({this.id, this.firstName, this.lastName,
    this.email, this.bio, this.imageURL, this.past});

  factory VolunteerDetailsForVolunteer.fromJson(Map<String, dynamic> json) {
    var list = json['past'] as List;
    return VolunteerDetailsForVolunteer(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      bio: json['bio'],
      imageURL: json['imageRoute'],
      past: list.map((o) => Opportunity.fromJson(o)).toList(),

    );
  }
}

class VolunteerDetailsForOrganization {
  int id;
  String firstName;
  String lastName;
  String email;
  String bio;
  String imageURL;
  List<Opportunity> past;

  VolunteerDetailsForOrganization({this.id, this.firstName, this.lastName,
    this.email, this.bio, this.imageURL, this.past});

  factory VolunteerDetailsForOrganization.fromJson(Map<String, dynamic> json) {
    var list = json['past'] as List;
    return VolunteerDetailsForOrganization(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      bio: json['bio'],
      imageURL: json['imageRoute'],
      past: list.map((o) => Opportunity.fromJson(o)).toList(),
    );
  }
}

class Volunteer {
  int id;
  String firstName;
  String lastName;
  String imageURL;

  Volunteer({this.id, this.firstName, this.lastName, this.imageURL});

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageURL: json['imageRoute'],
    );
  }
}

class VolunteerList {
  final List<Volunteer> volunteers;

  VolunteerList({
    this.volunteers,
  });

  factory VolunteerList.fromJson(List<dynamic> json) {

    List<Volunteer> volunteers = json.map((i) => Volunteer.fromJson(i)).toList();
    return new VolunteerList(
      volunteers: volunteers
    );
  }
}
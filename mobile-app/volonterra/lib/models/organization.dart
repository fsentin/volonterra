import 'package:volonterra/models/opportunity.dart';
class OrganizationDetails {
  int id;
  String name;
  String email;
  String description;
  String location;
  String imageURL;
  List<Opportunity> active;
  List<Opportunity> past;

  OrganizationDetails({this.id, this.name, this.email, this.description,
    this.location, this.imageURL, this.active, this.past});

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) {
    var list1 = json['active'] as List;
    var list2 = json['past'] as List;
    return OrganizationDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      description: json['description'],
      imageURL: json['imageRoute'],
      active: list1.map((i) => Opportunity.fromJson(i)).toList(),
      past: list2.map((i) => Opportunity.fromJson(i)).toList(),
    );
  }
}
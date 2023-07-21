import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/screens/organization/listvolunteers.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListVolunteersScreen extends StatefulWidget {
  final String title;
  final String route;
  ListVolunteersScreen({Key key, @required this.title, @required this.route})
      : super(key: key);
  @override
  _ListVolunteersScreenState createState() => _ListVolunteersScreenState();
}

class _ListVolunteersScreenState extends State<ListVolunteersScreen> {
  Future<VolunteerList> volunteers;

  Future<VolunteerList> loadVolunteers() async {
    final response = await http
        .get(Uri.parse(widget.route),
        headers: <String, String>{'Authorization': Routes.basicAuth});

    if (response.statusCode == 200) {
      return VolunteerList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load volunteers');
    }
  }

  @override
  void initState() {
    super.initState();
    volunteers = loadVolunteers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VolunteerList>(
      future: volunteers,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          return ListVolunteers(
              volunteers: snapshot.data.volunteers);

        } else if(snapshot.hasError) {
          return ErrorLoading();
        }
        return Center(
          child: const CircularProgressIndicator(),
        );
      },
    );
  }
}
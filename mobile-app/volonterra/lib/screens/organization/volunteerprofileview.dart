import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/screens/organization/listpastopportunitiesofvolunteer.dart';
import 'package:volonterra/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VolunteerProfileView extends StatefulWidget {
  final int volunteerId;

  VolunteerProfileView({Key key, @required this.volunteerId}) : super(key: key);

  @override
  _VolunteerProfileViewState createState() => _VolunteerProfileViewState();
}

class _VolunteerProfileViewState extends State<VolunteerProfileView> {
  Future<VolunteerDetailsForOrganization> volunteer;

  Future<VolunteerDetailsForOrganization> loadVolunteer() async {
    final response = await http.get(
        Uri.parse(Routes.BASE + '/volunteers/organization-view/'
            + widget.volunteerId.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth}
    );

    if (response.statusCode == 200) {
      return VolunteerDetailsForOrganization.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load volunteer.');
    }
  }

  @override
  void initState() {
    super.initState();
    volunteer = loadVolunteer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VolunteerDetailsForOrganization>(
        future: volunteer,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var volunteer = snapshot.data;
            return  SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 15,
                      ),
                      child: Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(60),
                            elevation: 7,
                            child: CircleAvatar(
                              radius: 60.0,
                              foregroundImage: NetworkImage(volunteer.imageURL),
                              backgroundImage: AssetImage(
                                  'assets/images/profile_placeholder.png'
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child:Container(
                                    width: 200,
                                    child: Text(volunteer.firstName + ' '
                                        + volunteer.lastName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(volunteer.email),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        left: 40,
                        right: 40,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Bio',
                          style: Styles.textStyleBlack,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 30,
                          right: 30
                      ),
                      child: Material(
                        color: Colors.white,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                left: 30,
                                right: 30,
                                bottom: 20,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(volunteer.bio == null
                                    ? "Hi there! I'm ready to volunteer!"
                                    : volunteer.bio),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 30,
                              right: 30,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('My past opportunities',
                                style: Styles.textStyleBlack,),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 30,
                            ),
                            child: ListPastOpportunities(
                              opportunities: volunteer.past,
                              volunteerId: widget.volunteerId,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          } else if(snapshot.hasError) {
            return ErrorLoading();
          }
          return Loading();
        }
    );
  }
}
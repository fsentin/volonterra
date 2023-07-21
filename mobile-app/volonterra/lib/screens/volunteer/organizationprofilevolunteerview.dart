import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/models/organization.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/screens/volunteer/listopportunities.dart';
import 'package:volonterra/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrganizationProfile extends StatefulWidget {
  final int organizationId;
  final int volunteerId;

  OrganizationProfile({Key key, @required this.organizationId,
    @required this.volunteerId}) : super(key: key);

  @override
  _OrganizationProfileState createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  Future<OrganizationDetails> organization;

  Future<OrganizationDetails> loadOrganization() async {
    final response = await http.get(
        Uri.parse(Routes.BASE + '/organizations/volunteer-view/' +
            widget.organizationId.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth}
    );

    if (response.statusCode == 200) {
      return OrganizationDetails.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load organization.');
    }
  }

  @override
  void initState() {
    super.initState();
    organization = loadOrganization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<OrganizationDetails>(
          future: organization,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var org = snapshot.data;
              return
                SingleChildScrollView(
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
                                  foregroundImage: NetworkImage(org.imageURL),
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
                                      child:  Container(
                                        width: 200,
                                        child: Text(
                                          org.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(org.email),
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
                            child: Text('Description',
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
                                    child: Text(org.description == null
                                        ? "Hi there! Hope you can help us!"
                                        : org.description),
                                  ),
                                ),
                              ],
                            ),
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
                            child: Text('Location',
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
                                    child: Text(org.location == null
                                        ? "We don't have one yet!"
                                        : org.location),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 30,
                              left: 10,
                              right: 10
                          ),
                          child: org.active.length == 0 ? null : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  left: 30,
                                  right: 30,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Our active opportunities',
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
                                child: ListOpportunities(
                                  opportunities: org.active,
                                  volunteerId: widget.volunteerId,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10
                          ),
                          child:  org.past.length == 0 ? null :Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  left: 30,
                                  right: 30,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Our past opportunities',
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
                                child: ListOpportunities(
                                  opportunities: org.past,
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
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/components/opportunityplaceholders.dart';
import 'package:volonterra/screens/organization/listvolunteers.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:volonterra/models/opportunity.dart';

class OpportunityScreen extends StatefulWidget {
  final int id;
  final int orgId;

  OpportunityScreen({Key key, @required this.id, this.orgId})
      : super(key: key);

  @override
  _OpportunityScreenState createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  Future<OpportunityDetailsForOrganization> opportunity;

  Future<OpportunityDetailsForOrganization> loadOpportunity() async {
    final response = await http.get(
        Uri.parse(Routes.BASE + '/opportunities/' + widget.id.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth}
    );

    if (response.statusCode == 200) {
      return OpportunityDetailsForOrganization.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load opportunity.');
    }
  }

  @override
  void initState() {
    super.initState();
    opportunity = loadOpportunity();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpportunityDetailsForOrganization>(
        future: opportunity,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var opportunity = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: SizedBox(
                          height: 220,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: new Image.network(opportunity.imageURL,
                              fit: BoxFit.fitWidth,
                              errorBuilder: (context, error, stackTrace) => OpportunityPlaceholder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(opportunity.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.group),
                                  SizedBox(width: 10),
                                  Text(opportunity.organizationName),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 10),
                                  Text(opportunity.location),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 10),
                                  Text(opportunity.startDate + " until "
                                      + opportunity.endDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description',
                            style: Styles.textStyleBlack,),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(opportunity.description),
                        ),
                      ),


                      SizedBox(height: 30),

                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Requirements',
                            style: Styles.textStyleBlack,),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(opportunity.requirements),
                        ),
                      ),


                      SizedBox(height: 30),

                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Tags',
                            style: Styles.textStyleBlack,),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 5,
                            children: List<Widget>.generate(opportunity.tags.length,
                                  (index){
                                return ActionChip(
                                  onPressed: (){},
                                  backgroundColor: Colors.white,
                                  elevation: 2,
                                  avatar: CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        opportunity.tags[index].imageURL
                                    ),
                                  ),
                                  label: Text(opportunity.tags[index].name
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      widget.orgId == null ? null :_options(opportunity.isActive,
                          opportunity.appliedVolunteers,
                      opportunity.acceptedVolunteers),
                    ],
                  ),
                ),
              ),
            );

          } else if(snapshot.hasError){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: ErrorLoading(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Loading(),
          );
        }
    );
  }

  void _finish() async {
    final api = Routes.BASE + '/opportunities/deactivate/'
        + widget.id.toString() + '/' + widget.orgId.toString();

    http.Response response = await http.post(Uri.parse(api),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Routes.basicAuth
      },
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully closed opportunity! Changes will be visible next time you log in.',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Request failed!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    }
    Navigator.pop(context, true);
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>
        OpportunityScreen(id: widget.id, orgId: widget.orgId)));
  }
  
  Widget _options(bool isActive, List<Volunteer> applied, List<Volunteer> accepted){
    if(isActive){
      return Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Applied volunteers',
                style: Styles.textStyleBlack,),
            ),
          ),
          SizedBox(height: 5),
          ListVolunteers(volunteers: applied, accept: false, id: widget.id),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Accepted volunteers',
                style: Styles.textStyleBlack,),
            ),
          ),
          SizedBox(height: 5),
          ListVolunteers(volunteers: accepted, accept: true, id: widget.id),
          SizedBox(height: 20),
          RedButton(
            displayedText: 'Deactivate',
            onPressed: () {
              _finish();
            },
          ),
          SizedBox(height: 25),
        ],
      );

    } else {
      return SizedBox(height: 30);
    }
  }
}
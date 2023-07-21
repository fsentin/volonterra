import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/components/opportunityplaceholders.dart';
import 'package:volonterra/screens/volunteer/listopportunitiesscreen.dart';
import 'package:volonterra/screens/volunteer/organizationprofilevolunteerview.dart';
import 'package:volonterra/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:volonterra/models/opportunity.dart';

class OpportunityScreen extends StatefulWidget {
  final int id;
  final int volunteerId;

  OpportunityScreen({Key key, @required this.id, @required this.volunteerId}) : super(key: key);

  @override
  _OpportunityScreenState createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {
  Future<OpportunityDetailsForVolunteer> opportunity;

  Future<OpportunityDetailsForVolunteer> loadOpportunity() async {
    final response = await http.get(
        Uri.parse(Routes.BASE + '/opportunities/' + widget.id.toString()
        + '/volunteer/' + widget.volunteerId.toString()),
            headers: <String, String>{'Authorization': Routes.basicAuth}
    );
    if (response.statusCode == 200) {
      return OpportunityDetailsForVolunteer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    return FutureBuilder<OpportunityDetailsForVolunteer>(
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
                              errorBuilder: (context, error, stackTrace) =>
                                  OpportunityPlaceholder(),
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
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrganizationProfile(
                                            organizationId: opportunity.organizationId,
                                            volunteerId: widget.volunteerId)
                                      ),
                                    );
                                  },
                                  child:Row(
                                    children: [
                                      Icon(Icons.group),
                                      SizedBox(width: 10),
                                      Text(opportunity.organizationName),
                                    ],
                                  ),
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
                                    Text(snapshot.data.startDate + " until "
                                        + snapshot.data.endDate),
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
                          child: Text(snapshot.data.description),
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
                          child: Text(snapshot.data.requirements),
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
                            children: List<Widget>.generate(snapshot.data.tags.length,
                              (index){
                              return ActionChip(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListOpportunitiesScreen(
                                          entry: snapshot.data.tags[index].name,
                                          route: Routes.BASE + '/tags/'
                                              + snapshot.data.tags[index].id.toString(),
                                          volunteerId: widget.volunteerId,
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: Colors.white,
                                elevation: 2,
                                avatar: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                      snapshot.data.tags[index].imageURL
                                  ),
                                ),
                                label: Text(snapshot.data.tags[index].name
                                ),
                              );
                              },
                            ),
                          ),
                        ),
                      ),
                      applyButton(snapshot.data.hasApplied),
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
              body: Center(
                child: const CircularProgressIndicator(),
              ),
          );
        }
    );
  }



  void _apply() async {
    final api = Routes.BASE + '/opportunities/' + widget.id.toString()
        + '/apply/' + widget.volunteerId.toString();
    http.Response response = await http.post(Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Routes.basicAuth,
        },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            'Succesfully applied!',
            style: GoogleFonts.raleway(),
          ),
      )
    );

    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => OpportunityScreen(
            id: widget.id,
            volunteerId: widget.volunteerId
        )
    ));
  }

  void _quit() async {
    final api = Routes.BASE + '/opportunities/' + widget.id.toString()
        + '/quit/' + widget.volunteerId.toString();
    http.Response response = await http.post(Uri.parse(api),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Routes.basicAuth,
      },
    );
    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully quit application!',
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
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>
        OpportunityScreen(id: widget.id, volunteerId: widget.volunteerId)));
  }


  Widget applyButton(bool hasApplied){
    if(!hasApplied){
      return Column(
        children: [
          SizedBox(height: 30),
          BlackButton(displayedText: 'Apply',
              onPressed: () {
                _apply();
              }
          ),
          SizedBox(height: 25),
        ],
      );
    }
    return Column(
      children: [
        SizedBox(height: 30),
        RedButton(
          displayedText: 'Quit application',
          onPressed: () {
            _quit();
          },
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
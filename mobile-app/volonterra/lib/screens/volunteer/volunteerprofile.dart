import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/screens//common/editpicture.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/screens/volunteer/listopportunities.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VolunteerProfile extends StatefulWidget {
  final int id;

  VolunteerProfile({Key key, @required this.id}) : super(key: key);

  @override
  _VolunteerProfileState createState() => _VolunteerProfileState();
}

class _VolunteerProfileState extends State<VolunteerProfile> {
  Future<VolunteerDetailsForVolunteer> volunteer;

  Future<VolunteerDetailsForVolunteer> loadVolunteer() async {
    final response = await http.get(
        Uri.parse(Routes.BASE + '/volunteers/volunteer-view/'
            + widget.id.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth});

    if (response.statusCode == 200) {
      return VolunteerDetailsForVolunteer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    return FutureBuilder<VolunteerDetailsForVolunteer>(
        future: volunteer,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var volunteer = snapshot.data;
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
                           Stack(
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
                                   padding: EdgeInsets.only(left: 75.0, top: 75.0),
                                   child: new Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Container(
                                         width: 35,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           shape: BoxShape.circle,
                                           boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey, spreadRadius: 0.5)],
                                         ),
                                         child: GestureDetector(
                                           onTap: (){
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(
                                                   builder: (context) => EditPictureScreen(
                                                       id: widget.id,
                                                        isVolunteer: true,
                                                   ),
                                               ),
                                             );

                                           },
                                           child: CircleAvatar(
                                             backgroundColor: Colors.white,
                                             radius: 30.0,
                                             child: new Icon(
                                               Icons.edit,
                                               size: 19,
                                               color: Styles.black,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   )),
                             ],
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
                                    child: Container(
                                      width: 200,
                                      child: Text(
                                        volunteer.firstName + ' ' + volunteer.lastName,
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
                            style: Styles.textStyleBlack,
                          ),
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
                              child: ListOpportunities(
                                opportunities: volunteer.past,
                                volunteerId: widget.id,
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
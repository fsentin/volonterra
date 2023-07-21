import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/shared.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EditVolunteerProfileScreen extends StatefulWidget {
  final int volunteerId;

  EditVolunteerProfileScreen ({Key key, @required this.volunteerId})
      : super(key: key);

  @override
  _EditVolunteerProfileScreenState createState() => _EditVolunteerProfileScreenState();
}


class _EditVolunteerProfileScreenState extends State<EditVolunteerProfileScreen> {
  String _firstName, _lastName, _bio, _email, _password, _newPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<VolunteerDetailsForVolunteer> loadVolunteer() async {
    print("I'm here");
    final response = await http.get(
        Uri.parse(Routes.BASE + '/volunteers/volunteer-view/'
            + widget.volunteerId.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth}
    );
    if (response.statusCode == 200) {
      var v = VolunteerDetailsForVolunteer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return v;
    } else {
      throw Exception('Failed to load volunteer.');
    }
  }

  void _edit() async {
    final api = Routes.BASE + '/volunteers/edit/'+ widget.volunteerId.toString();
    Map editinfo = {
      'id' : widget.volunteerId,
      'firstName' : _firstName,
      'lastName' : _lastName,
      'email' : _email,
      'bio' : _bio,
      'password' : _password,
      'newPassword' : _newPassword
    };
    http.Response response = await http.post(Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Routes.basicAuth
        },
        body:jsonEncode(editinfo));

    if(response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully edited profile!',
              style: GoogleFonts.raleway(),
            ),
          )
      );

    } else {
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to edit! Try again.',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadVolunteer();
  }

  @override
  Widget build(BuildContext context) {

    final passwordField = TextFormField(
      onChanged: (value) {
        _password = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your current password.';
        } else if(value.length < 8) {
          return 'Password should have at least 8 characters.';
        }
        return null;
      },

      obscureText: true,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Current Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );


    final newPasswordField = TextFormField(
      onChanged: (value) {
        _newPassword = value;
      },

      validator: (value) {
        if(value != null && value.isNotEmpty && value.length < 8) {
          return 'Password should have at least 8 characters.';
        }
        return null;
      },

      obscureText: true,

      decoration: InputDecoration(
          helperText: "Leave empty if you don't want to change password.",
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "New Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );


    final submitButton = BlackButton(
        displayedText: 'Submit',
        onPressed: () {
          if(_formKey.currentState.validate()) {
            if(_password != null && _newPassword != null
                && _password.compareTo(_newPassword) == 0){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Old and new password can't be equal.",
                      style: GoogleFonts.raleway(),
                    ),
                  )
              );
            } else {
              _formKey.currentState.save();
              _edit();
            }
          }
        }
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit your profile',
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,),),),
      ),
      body: FutureBuilder<VolunteerDetailsForVolunteer>(
          future: loadVolunteer(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var volunteer = snapshot.data;
              _firstName = volunteer.firstName;
              _lastName = volunteer.lastName;
              _email = volunteer.email;
              _bio = volunteer.bio;
              return Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(36),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: volunteer.firstName,
                            onChanged: (value) {
                              _firstName = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter new first name.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: "First name",
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: volunteer.lastName,
                            onChanged: (value) {
                              _lastName = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter new last name.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: "Last name",
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: volunteer.email,
                            onChanged: (value) {
                              _email = value;
                            },

                            validator: (value) {
                              if (value == null || !RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return 'Please enter valid email.';
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              labelText: "Email",
                              contentPadding: Styles.insets,
                              border: Styles.border,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: volunteer.bio,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              _bio = value;
                            },

                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your new bio.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: "Bio",
                                fillColor: Colors.white,
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                            ),
                          ),
                          SizedBox(height: 10),
                          passwordField,
                          SizedBox(height: 10),
                          newPasswordField,
                          SizedBox(height: 20),
                          submitButton,
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Loading();
          }
      ),
    );
  }

}
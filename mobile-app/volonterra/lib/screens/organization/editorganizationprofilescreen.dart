import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/models/organization.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/shared.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EditOrganizationProfileScreen extends StatefulWidget {
  final int orgId;

  EditOrganizationProfileScreen ({Key key, @required this.orgId})
      : super(key: key);

  @override
  _EditOrganizationProfileScreenState createState() => _EditOrganizationProfileScreenState();
}


class _EditOrganizationProfileScreenState extends State<EditOrganizationProfileScreen> {
  String _name,  _description, _email, _location, _password, _newPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<OrganizationDetails> loadOrg() async {
    final response = await http.get(
        Uri.parse(Routes.BASE + '/organizations/organization-view/'
            + widget.orgId.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth}
    );
    if (response.statusCode == 200) {
      var o = OrganizationDetails.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return o;
    } else {
      throw Exception('Failed to load organization.');
    }
  }

  void _edit() async {
    final api = Routes.BASE + '/organizations/edit/'+ widget.orgId.toString();
    Map editInfo = {
      'id' : widget.orgId,
      'name' : _name,
      'email' : _email,
      'description' : _description,
      'location' : _location,
      'password' : _password,
      'newPassword' : _newPassword
    };
    http.Response response = await http.post(Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Routes.basicAuth
        },
        body:jsonEncode(editInfo));

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
      body: FutureBuilder<OrganizationDetails>(
          future: loadOrg(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var org = snapshot.data;
              _name = org.name;
              _email = org.email;
              _description = org.description;
              _location = org.location;
              return Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(36),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: org.name,
                            onChanged: (value) {
                              _name = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter organization name.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: "Organization name",
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: org.location,
                            onChanged: (value) {
                              _location = value;
                            },
                            validator: (value) {
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: "Location",
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: org.email,
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
                            initialValue: org.description,
                            keyboardType: TextInputType.multiline,
                            onChanged: (value) {
                              _description = value;
                            },

                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your description.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                labelText: "Description",
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
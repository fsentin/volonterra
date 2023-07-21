import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/screens/volunteer/mainscreen.dart';
import 'package:volonterra/models/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreenVolunteer extends StatefulWidget {
  @override
  _SignUpScreenVolunteerState createState() => _SignUpScreenVolunteerState();
}

class _SignUpScreenVolunteerState extends State<SignUpScreenVolunteer> {
  String _firstName, _lastName, _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final firstNameField = TextFormField(
      onChanged: (value) {
        _firstName = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name.';
        }
        return null;
      },

      decoration: InputDecoration(
          labelText: "First name",
          //icon: Icon(Icons.person),
          contentPadding: Styles.insets,
          border: Styles.border,
      ),
    );

    final lastNameField = TextFormField(
      onChanged: (value) {
        _lastName = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name.';
        }
        return null;
      },

      decoration: InputDecoration(
          labelText: "Last name",
          //icon: Icon(Icons.supervised_user_circle),
          contentPadding: Styles.insets,
          border: Styles.border,
      ),
    );

    final emailField = TextFormField(
      onChanged: (value) {
        _email = value;
      },

      validator: (value) {
        if (value == null || !RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter valid email.';
        } else if(value != null && value.compareTo("admin@volonterra.hr") == 0){
          return "You can't use this email.";
        }
        return null;
      },

      decoration: InputDecoration(
          labelText: "Email",
          contentPadding: Styles.insets,
          border: Styles.border,
      ),
    );

    final passwordField = TextFormField(
      onChanged: (value) {
        _password = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password.';
        } else if(value.length < 8) {
          return 'Password should have at least 8 characters.';
        }
        return null;
      },

      obscureText: true,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );

    final snackBar = SnackBar(
      content: Text(
        'Sign up failed!',
        style: GoogleFonts.raleway(),
      ),
    );

    void _registerCommand() async {
      final api = Routes.BASE + '/registration/volunteer';
      Routes.basicAuth = 'Basic ' + base64Encode(utf8.encode(_email + ':' + _password));
      Map registerinfo = {
        'firstName' : _firstName,
        'lastName' : _lastName,
        'email' : _email,
        'password' : _password,
      };

      http.Response response = await http.post(Uri.parse(api),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(registerinfo));

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        var resp = LoginResponse.fromJson(data);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreenVolunteer(id: resp.id),
          ), (Route<dynamic> route) => false,
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    final signUpButton = BlackButton(
        displayedText: 'Sign up',
        onPressed: () {
          if(_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _registerCommand();
          }
        }
    );

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(  // <-- wrap this around
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    SizedBox(
                      height: 50.0,
                      child: new Image.asset(
                        'assets/images/signup_volunteer.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    firstNameField,
                    SizedBox(height: 10.0),
                    lastNameField,
                    SizedBox(height: 10.0),
                    emailField,
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(height: 25.0),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: signUpButton,
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
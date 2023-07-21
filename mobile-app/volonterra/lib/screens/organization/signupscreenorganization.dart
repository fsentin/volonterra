import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/screens/organization/mainscreen.dart';
import 'package:volonterra/models/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreenOrganization extends StatefulWidget {
  @override
  _SignUpScreenOrganizationState createState() => _SignUpScreenOrganizationState();
}

class _SignUpScreenOrganizationState extends State<SignUpScreenOrganization> {
  String _name, _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final nameField = TextFormField(
      onChanged: (value) {
        _name = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name.';
        }
        return null;
      },

      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Organization name",
          //icon: Icon(Icons.person),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
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
          labelText: "Password",
          //icon: Icon(Icons.security),
          contentPadding: Styles.insets,
          border: Styles.border,
      ),
    );


    final snackBar = SnackBar(
      content: Text(
        'Sign up failed!',
        style: GoogleFonts.raleway(),
      ),
    );

    void _registerCommand() async {
      final api = Routes.BASE + '/registration/organization';
      Routes.basicAuth = 'Basic ' + base64Encode(utf8.encode(_email + ':' + _password));
      //json maping user entered details
      Map registerinfo ={
        'name': _name,
        'email':_email,
        'password': _password,
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
            builder: (context) => MainScreenOrganization(id: resp.id),
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
                        'assets/images/signup_organization.png',
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
                    nameField,
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
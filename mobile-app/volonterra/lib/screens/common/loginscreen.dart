import 'package:flutter/material.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/screens/admin/mainscreen.dart';
import 'package:volonterra/screens/organization/mainscreen.dart';
import 'package:volonterra/screens/volunteer/mainscreen.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/models/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
      onChanged: (value) {
        _email = value;
      },

      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Please enter your email.';
        }
        else if (!RegExp(
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
          contentPadding: Styles.insets,
          border: Styles.border,
      ),
    );

    final snackBar = SnackBar(
      content: Text(
          'Email and password combination is incorrect.',
        style: GoogleFonts.raleway(),
      ),
    );

    void _loginCommand() async {
      final api = Routes.BASE + '/login';

      Map logininfo = {
        'email' : _email,
        'password' :  _password,
      };

      http.Response response = await http.post(Uri.parse(api),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(logininfo)
      );

      if (response.statusCode == 200) {
        Routes.basicAuth = 'Basic ' + base64Encode(utf8.encode(_email + ':' + _password));

        if(_email.compareTo("admin@volonterra.hr")==0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreenAdmin(),
            ), (Route<dynamic> route) => false,
          );
        }

        var data = jsonDecode(utf8.decode(response.bodyBytes));
        var resp = LoginResponse.fromJson(data);
        if(resp.isVolunteer){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreenVolunteer(id: resp.id),
            ), (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreenOrganization(id: resp.id),
            ), (Route<dynamic> route) => false,
          );
        }
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    final loginButton = BlackButton(
        displayedText: 'Log in',
        onPressed: () {
          if(_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _loginCommand();
          }
        });

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(  // <-- wrap this around
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 300.0,
                      child: new Image.asset(
                        'assets/images/volonterra_logo_alt.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    emailField,
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(height: 25.0),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: loginButton,
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
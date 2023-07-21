import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/screens/organization/signupscreenorganization.dart';
import 'package:volonterra/screens/volunteer/signupscreenvolunteer.dart';
import 'package:volonterra/styles.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Text('Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                    ),
                  ),

                  SizedBox(height: 50.0),

                  SizedBox(
                    width: 250,
                    height: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreenVolunteer()),
                        );
                      },
                      style: Styles.btnStyleWhite,
                      child: Column(
                        children: <Widget> [
                          SizedBox(height: 20.0),
                          new Image.asset(
                              'assets/images/signup_volunteer.png',
                              fit: BoxFit.contain,
                              width: 70
                          ),
                          SizedBox(height: 10.0),
                          Text("As Volunteer",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: Styles.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  SizedBox(
                    width: 250,
                    height: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreenOrganization()),
                        );
                      },
                      style: Styles.btnStyleWhite,
                      child: Column(
                        children: <Widget> [
                          SizedBox(height: 20.0),
                          new Image.asset(
                              'assets/images/signup_organization.png',
                              fit: BoxFit.contain,
                              width: 70
                          ),
                          SizedBox(height: 10.0),
                          Text("As Organization",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: Styles.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
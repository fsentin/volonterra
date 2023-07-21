import 'package:flutter/material.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:volonterra/screens/common/loginscreen.dart';
import 'package:volonterra/screens/common/signupscreen.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 70.0),
                        SizedBox(
                          height: 300.0,
                          child: new Image.asset(
                            'assets/images/volonterra_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: BlackButton(
                            displayedText: "Log in",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: WhiteButton(
                            displayedText: "Sign up",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
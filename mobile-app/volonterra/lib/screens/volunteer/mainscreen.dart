import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/screens/common/loginscreen.dart';
import 'package:volonterra/screens/volunteer/editvolunteerprofilescreen.dart';
import 'package:volonterra/screens/volunteer/homescreen.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/screens/volunteer/explore.dart';
import 'package:volonterra/screens/volunteer/volunteerprofile.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreenVolunteer extends StatefulWidget {
  final int id;

  MainScreenVolunteer ({Key key, //@required
    this.id}) : super(key: key);

  @override
  _MainScreenVolunteerState createState() => _MainScreenVolunteerState();
}

class _MainScreenVolunteerState extends State<MainScreenVolunteer> {
  String _title = 'News';
  int _selectedIndex = 0;

  static List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomeScreen(volunteerId: widget.id),
      Explore(volunteerId: widget.id,),
      VolunteerProfile(id: widget.id),
    ];
  }

  // change appbar title depending on the tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case 0: { _title = 'News'; }
        break;
        case 1: { _title = 'Explore'; }
        break;
        case 2: { _title = 'Profile'; }
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        backgroundColor: Colors.white,
        title: Text(_title,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      endDrawer:  _selectedIndex != 2 ? null : Drawer(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: ListTile(
                trailing: Icon(Icons.exit_to_app_rounded, color: Styles.black,),
                title: Text("Log out", style: TextStyle(fontSize: 15)),
                onTap: () {
                  Routes.basicAuth = '';
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ), (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedIndex != 2 ? null:
      FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.white,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditVolunteerProfileScreen(
                    volunteerId: widget.id
                )
            ),
          ).then((_) => setState((){}));
        },
        child: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        iconSize: 30,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        selectedItemColor: Styles.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'News'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Explore'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile'
          ),
        ],
      ),
    );
  }
}

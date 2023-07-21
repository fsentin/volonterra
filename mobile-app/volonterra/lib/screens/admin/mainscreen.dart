import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/screens/admin/listopportunitiesscreen.dart';
import 'package:volonterra/screens/admin/volunteers.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/screens/common/loginscreen.dart';

import 'package:volonterra/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreenAdmin extends StatefulWidget {

  @override
  _MainScreenAdminState createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin> {
  String _title = 'Opportunities';
  int _selectedIndex = 0;

  static List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      ListOpportunitiesScreen(route: Routes.BASE + '/opportunities/retrieve'),
      Center(
        child:  Icon(Icons.apartment_rounded),
      ),
      Volunteers()
    ];
  }

  // change appbar title depending on the tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case 0: { _title = 'Opportunities'; }
        break;
        case 1: { _title = 'Organizations'; }
        break;
        case 2: { _title = 'Volunteers'; }
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
              icon: Icon(Icons.art_track_rounded),
              label: 'Opportunities'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.apartment_rounded),
              label: 'Organizations'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'Volunteers'
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/screens/common/loginscreen.dart';
import 'package:volonterra/screens/organization/createopportunity.dart';
import 'package:volonterra/screens/organization/editorganizationprofilescreen.dart';
import 'package:volonterra/screens/organization/homescreen.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/screens/organization/explore.dart';
import 'package:volonterra/screens/organization/organizationprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/shared.dart';

class MainScreenOrganization extends StatefulWidget {
  final int id;

  MainScreenOrganization({Key key, //@required
    this.id}) : super(key: key);

  @override
  _MainScreenOrganizationState createState() => _MainScreenOrganizationState();
}

class _MainScreenOrganizationState extends State<MainScreenOrganization> {
  String _title = 'Active Opportunities';
  int _selectedIndex = 0;

  static List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      ListOpportunitiesScreen(orgId: widget.id),
      Explore(),
      OrganizationProfile(orgId: widget.id),
    ];
  }

  // change appbar title depending on the tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case 0: { _title = 'Our Active Opportunities'; }
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
      floatingActionButton: floatingButton(),
      body: _pages[_selectedIndex],
      endDrawer:  _selectedIndex != 2 ? null : Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: ListTile(
              trailing: Icon(Icons.exit_to_app_rounded, color: Styles.black),
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
              icon: Icon(Icons.home),
              label: 'Our active Opportunities',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
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

  Widget floatingButton(){
    switch(_selectedIndex){
      case 0 : return FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.white,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateOpportunity(
                    orgId: widget.id
                )
            ),
          ).then((_) => setState((){}));
        },
        child: Center(
          child: Icon(Icons.add),
        ),
      );
      break;
      case 2: return FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.white,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditOrganizationProfileScreen(
                    orgId: widget.id
                )
            ),
          ).then((_) => setState((){}));
        },
        child: Center(
          child: Icon(Icons.edit),
        ),
      );
      break;
      default: return null;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/screens/volunteer/listopportunities.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/models/opportunity.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ListOpportunitiesScreen extends StatefulWidget {
  final int volunteerId;
  // name of the screen displayed in appbar
  final String entry;
  // route at which the opportunities are fetched
  String route;
  ListOpportunitiesScreen({Key key, @required this.volunteerId, @required this.entry,
    @required this.route}) : super(key: key);
  @override
  _ListOpportunitiesScreenState createState() => _ListOpportunitiesScreenState();
}


class _ListOpportunitiesScreenState extends State<ListOpportunitiesScreen> {
  Future<OpportunitiesList> opportunities;

  Future<OpportunitiesList> loadOpportunities() async {
    print(widget.entry);
    if(widget.entry != null || widget.entry.isNotEmpty){
      widget.route += '/?search=' + widget.entry;
    }

    print(widget.route);
    final response = await http.get(Uri.parse(widget.route),
        headers: <String, String>{'Authorization': Routes.basicAuth});

    if (response.statusCode == 200) {
      return OpportunitiesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load opportunities');
    }
  }

  @override
  void initState() {
    super.initState();
    opportunities = loadOpportunities();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.entry,
          style: GoogleFonts.raleway(
          textStyle: TextStyle(
          fontWeight: FontWeight.w600,
           ),
          ),
        ),
      ),

      body: FutureBuilder<OpportunitiesList>(future: opportunities,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var opportunities = snapshot.data.opportunities;

              return Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: ListOpportunities(
                    opportunities: opportunities,
                    volunteerId: widget.volunteerId,
                  ),
              );

            } else if(snapshot.hasError){
              return ErrorLoading();
            }
            return Loading();
          }
      ),
    );
  }

}
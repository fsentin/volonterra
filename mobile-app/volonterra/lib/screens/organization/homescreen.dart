import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/screens/organization/listopportunities.dart';
import 'package:volonterra/models/opportunity.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ListOpportunitiesScreen extends StatefulWidget {
  final int orgId;

  ListOpportunitiesScreen({Key key, @required this.orgId}) : super(key: key);
  @override
  _ListOpportunitiesScreenState createState() => _ListOpportunitiesScreenState();
}


class _ListOpportunitiesScreenState extends State<ListOpportunitiesScreen> {
  Future<OpportunitiesList> _loadOpportunities() async {
    final response = await http.get(Uri.parse(
        Routes.BASE + '/organizations/active-opportunities/'
            + widget.orgId.toString()),
        headers: <String, String>{'Authorization': Routes.basicAuth});

    if (response.statusCode == 200) {
      return OpportunitiesList.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load opportunities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OpportunitiesList>(
      future: _loadOpportunities(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20
              ),
              child: ListOpportunities(
                opportunities: snapshot.data.opportunities,
                orgId: widget.orgId,
              ),
            ),
          );
        } else if(snapshot.hasError) {
          return Center(
            child: Text('Not available at the moment.'),
          );
        }
        return Center(
          child: const CircularProgressIndicator(),
        );
      },
    );
  }
}
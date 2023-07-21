import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/screens/volunteer/listopportunities.dart';
import 'package:volonterra/models/opportunity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:volonterra/styles.dart';

class HomeScreen extends StatefulWidget {
  final int volunteerId;

  HomeScreen({Key key, @required this.volunteerId})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();

}


class _HomeScreenState extends State<HomeScreen> {

  Future<OpportunitiesList> _loadAcceptedOpportunities() async {
    final response = await http.get(Uri.parse(Routes.BASE + '/volunteers/'
        + widget.volunteerId.toString() + '/accepted'),
        headers: <String, String>{'Authorization': Routes.basicAuth});
    print(response.statusCode);

    if (response.statusCode == 200) {
      return OpportunitiesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load opportunities');
    }
  }

  Future<OpportunitiesList> _loadAppliedOpportunities() async {
    final response = await http.get(Uri.parse(Routes.BASE + '/volunteers/'
        + widget.volunteerId.toString() + '/applied'),
        headers: <String, String>{'Authorization': Routes.basicAuth}
        );

    if (response.statusCode == 200) {
      return OpportunitiesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load opportunities');
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Column(
               children: [
                  accepted(),
                  applied(),
                ],
        ),
      ),
      ),
    );
  }

  Widget accepted(){

    return Column(
      children: [
        FutureBuilder<OpportunitiesList>(
            future: _loadAcceptedOpportunities(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var opportunities = snapshot.data.opportunities;
                if(opportunities.isEmpty){
                  return Text('');
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30, left: 30, right: 30),
                        child: Align(alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text('Accepted opportunities',
                                style: Styles.textStyleBlack,
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.done_all_rounded)
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20),
                        child: ListOpportunities(
                          opportunities: opportunities,
                          volunteerId: widget.volunteerId,
                        ),
                      ),
                    ],
                  );
                }
              } else if(snapshot.hasError){
                return ErrorLoading();
              }
              return Loading();
            }
            ),
      ],
    );
  }

  Widget applied(){
    return FutureBuilder<OpportunitiesList>(future: _loadAppliedOpportunities(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var opportunities = snapshot.data.opportunities;
            if(opportunities.isEmpty){
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      Text("You have no pending opportunities.",
                        style: TextStyle(fontSize: 16),),
                      SizedBox(height: 17),
                      Text("Start exploring!", style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20),
                      new Image.asset(
                        'assets/images/emptystate.png',
                        fit: BoxFit.contain,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30, left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text('Pending opportunities',
                            style: Styles.textStyleBlack,
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.access_time_rounded)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: ListOpportunities(
                      opportunities: opportunities,
                      volunteerId: widget.volunteerId,
                    ),
                  )
                ],
              );
            }

          } else if(snapshot.hasError){
            return ErrorLoading();
          }
          return SizedBox(width: 0,);
        }
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/models/tag.dart';
import 'package:volonterra/screens/volunteer/listopportunitiesscreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  final int volunteerId;

  Explore({Key key,// @required
  this.volunteerId}) : super(key: key);
  @override
  _ExploreState createState() => _ExploreState();
}

  class _ExploreState extends State<Explore> {
  Future<TagsList> tags;
  String search = '';
  final _formKey = GlobalKey<FormState>();

  Future<TagsList> loadTags() async {
    final response = await http
        .get(Uri.parse(Routes.BASE + '/tags/all'),
        headers: <String, String>{'Authorization': Routes.basicAuth}
        );

    if (response.statusCode == 200) {
      return TagsList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tags');
    }
  }

  @override
  void initState() {
    super.initState();
    tags = loadTags();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 20, 10),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        search = value;
                      },
                      decoration: InputDecoration(
                        hintText: "  Search opportunities",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOpportunitiesScreen(
                                  entry: search,
                                  route: Routes.BASE + '/opportunities/retrieve',
                                  volunteerId: widget.volunteerId,
                              ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<TagsList>(
              future: tags,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return GridView.builder(
                      padding: EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.5/1,
                          crossAxisCount: 2),
                      itemCount: snapshot.data.tags.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListOpportunitiesScreen(
                                      entry: snapshot.data.tags[index].name,
                                      route: Routes.BASE + '/tags/'
                                          + snapshot.data.tags[index].id.toString(),
                                      volunteerId: widget.volunteerId,
                                    ),
                                ),
                              );
                            },
                            style: Styles.btnStyleWhite,
                            child: Column(
                              children: <Widget> [
                                SizedBox(height: 10),
                                new Image.network(snapshot.data.tags[index].imageURL,
                                    fit: BoxFit.contain,
                                    width: 60
                                ),
                                Text(snapshot.data.tags[index].name,
                                  style: Styles.textStyleBlack,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );

                } else if(snapshot.hasError){
                  return ErrorLoading();
                }
                return Loading();
              },
            ),
          ),
        ],
      ),
    );
  }
}
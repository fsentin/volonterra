import 'package:flutter/material.dart';
import 'package:volonterra/components/opportunityplaceholders.dart';
import 'package:volonterra/screens/volunteer/opportunityscreen.dart';
import 'package:volonterra/styles.dart';
import 'package:volonterra/models/opportunity.dart';

class ListOpportunities extends StatefulWidget {
  final List<Opportunity> opportunities;
  final int volunteerId;

  ListOpportunities({Key key, @required this.opportunities,
    @required this.volunteerId}) : super(key: key);
  @override
  _ListOpportunitiesState createState() => _ListOpportunitiesState();
}

class _ListOpportunitiesState extends State<ListOpportunities> {

  @override
  Widget build(BuildContext context) {
    if(widget.opportunities.length == 0) {
      return Center(
        child: Text('No opportunities yet.'),
      );
    }

    return SingleChildScrollView(
      child:  Column(
        children: List<Widget>.generate(widget.opportunities.length,
              (index) {
            return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OpportunityScreen(
                      id: widget.opportunities[index].id,
                      volunteerId: widget.volunteerId,
                    ),
                  ),
                ).then((value) => setState(() {}));
              },
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          child: new Image.network(widget.opportunities[index].imageURL,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) => OpportunityPlaceholder(),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(widget.opportunities[index].name,
                          style: Styles.textStyleBlack,
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.grey,
                              size: 15.0,
                            ),
                            SizedBox(width: 5),
                            Text(widget.opportunities[index].organizationName),
                            SizedBox(width: 10),
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 15.0,
                            ),
                            SizedBox(width: 5),
                            Text(widget.opportunities[index].location),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          },
        ),
      ),
    );
  }
}
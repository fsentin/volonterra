import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/screens/organization/volunteerprofileview.dart';
import 'package:volonterra/styles.dart';

class ListVolunteers extends StatefulWidget {
  final List<Volunteer> volunteers;

  ListVolunteers({Key key, @required this.volunteers})
      : super(key: key);
  @override
  _ListVolunteersState createState() => _ListVolunteersState();
}

class _ListVolunteersState extends State<ListVolunteers> {

  @override
  Widget build(BuildContext context) {

    if(widget.volunteers.length == 0){
      return Center(
        child: Text('None yet.'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      itemCount: widget.volunteers.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(backgroundColor: Colors.white),
                  body: VolunteerProfileView(
                    volunteerId: widget.volunteers[index].id,
                  ),
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 10,
            child: ListTile(
              title: Text(widget.volunteers[index].firstName + ' ' +
                  widget.volunteers[index].lastName,
              ),
              leading: CircleAvatar(
                foregroundImage: NetworkImage(
                    widget.volunteers[index].imageURL
                ),
                backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                backgroundColor: Styles.lightBlue,
              ),
            ),
          ),
        );
      },
    );
  }

}
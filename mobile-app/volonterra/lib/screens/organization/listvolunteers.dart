import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/models/volunteer.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/screens/organization/volunteerprofileview.dart';
import 'package:volonterra/styles.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class ListVolunteers extends StatefulWidget {
  final List<Volunteer> volunteers;
  final bool accept;
  final int id;
  ListVolunteers({Key key, @required this.volunteers, this.accept, this.id})
      : super(key: key);
  @override
  _ListVolunteersState createState() => _ListVolunteersState();
}

class _ListVolunteersState extends State<ListVolunteers> {
  void _acceptVolunteer(int volunteerId) async {
    final api = Routes.BASE + '/opportunities/'
        + widget.id.toString() + '/accept/' + volunteerId.toString();

    http.Response response = await http.post(Uri.parse(api),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Routes.basicAuth
      },
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully accepted volunteer!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Request failed!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    }
    Navigator.pop(context);
  }

  void _removeVolunteer(int volunteerId) async {
    final api = Routes.BASE + '/opportunities/'
        + widget.id.toString() + '/decline/' + volunteerId.toString();

    http.Response response = await http.post(Uri.parse(api),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Routes.basicAuth
      },
    );
    print('STATUS KOD' +response.statusCode.toString());
    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully declined volunteer!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Request failed!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    }
    Navigator.pop(context);
  }

  Widget accept(int volunteerId){
    return IconButton(
        icon: Icon(Icons.remove),
        onPressed: (){
          _removeVolunteer(volunteerId);
        });
  }
  Widget applied(int volunteerId){

    print(widget.id.toString());
    return IconButton(
        icon: Icon(Icons.done_rounded),
        onPressed: (){
          _acceptVolunteer(volunteerId);
        });
  }

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
              trailing: widget.accept == null ? null : (widget.accept ?
              accept(widget.volunteers[index].id,): applied(widget.volunteers[index].id,)),
            ),
          ),
        );
      },
    );
  }

}
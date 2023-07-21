import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/components/buttons.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:volonterra/shared.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:volonterra/models/tag.dart';
import 'package:volonterra/components/errorloading.dart';
import 'package:volonterra/styles.dart';


class CreateOpportunity extends StatefulWidget {
  final int orgId;

  CreateOpportunity({Key key, @required this.orgId}) : super(key: key);
  @override
  _CreateOpportunityState createState() => _CreateOpportunityState();
}


class _CreateOpportunityState extends State<CreateOpportunity > {
  String _name, _description, _requirements, _location;
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now();
  File _file;
  String _base64Image;
  List<bool> _checked;
  bool _flag = true;
  List<int> _tagIds = [];



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<TagsList> loadTags() async {
    final response = await http
        .get(Uri.parse(Routes.BASE + '/tags/all'),
        headers: <String, String>{'Authorization': Routes.basicAuth});

    if (response.statusCode == 200) {
      var list = TagsList.fromJson(jsonDecode(response.body));
      if(_flag) {
        _checked = List<bool>.filled(list.tags.length, false);
        _flag = false;
      }
      return list;
    } else {
      throw Exception('Failed to load tags');
    }
  }


  void chooseImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile image = await picker.pickImage(source: ImageSource.gallery);
    final path = image.path;
    final bytes = await File(path).readAsBytes();
    setState(() {
      _file = File(path);
      _base64Image = base64Encode(bytes);
    });
  }

  void _createOpportunity() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final api = Routes.BASE + '/opportunities/new/'+ widget.orgId.toString();
    //json maping user entered details
    Map createinfo = {
      'name' : _name,
      'description' : _description,
      'requirements' : _requirements,
      'location' : _location,
      'start': formatter.format(_start),
      'end' : formatter.format(_end),
      'image' : _base64Image,
      'tags' : _tagIds,
    };
    print(createinfo);

    http.Response response = await http.post(Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': Routes.basicAuth
        },
        body:jsonEncode(createinfo));

    if (response.statusCode == 200) {

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully created opportunity!',
              style: GoogleFonts.raleway(),
            ),
          )
      );

    } else {
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed creation!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    final nameField = TextFormField(
      onChanged: (value) {
        _name = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter name of the position.';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Role name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );

    final descriptionField = TextFormField(
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        _description = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter description of the oportunity.';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Description",
          fillColor: Colors.white,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );

    final requirementsField = TextFormField(
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        _requirements = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter requirements of the opportunity.';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Requirements",
          fillColor: Colors.white,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );

    final locationField = TextFormField(
      onChanged: (value) {
        _location = value;
      },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter location of the opportunity.';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Location",
          fillColor: Colors.white,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );

    final startField = CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: GoogleFonts.raleway(
            fontSize: 20,
          ),
          ),
      ),
        child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (datetime){
              _start = datetime;
            }
        ),
    );

    final endField = CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: GoogleFonts.raleway(
            fontSize: 20,
          ),
        ),
      ),
      child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (datetime){
            _end = datetime;
          }
      ),
    );

    final createButton = BlackButton(
        displayedText: 'Create',
        onPressed: () {
          if(_formKey.currentState.validate()) {
            if(_start.isBefore(_end) && _start.isAfter(DateTime.now())) {
              _formKey.currentState.save();
              _createOpportunity();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Check your dates!',
                      style: GoogleFonts.raleway(),
                    ),
                  )
              );
            }
          }
        }
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Create new opportunity',
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          ),
        ),),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(36),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  uploadButton(),
                  SizedBox(height: 30),
                  nameField,
                  SizedBox(height: 10),
                  descriptionField,
                  SizedBox(height: 10),
                  requirementsField,
                  SizedBox(height: 10),
                  locationField,
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('  Start date',
                      style: TextStyle(fontSize: 18, color: Colors.black54),),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 100,
                    child: startField,
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('  End date',
                      style: TextStyle(fontSize: 18, color: Colors.black54),),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 100,
                    child: endField,
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('  Tags for this opportunity',
                      style: TextStyle(fontSize: 18, color: Colors.black54),),
                  ),
                  SizedBox(height: 10),
                  tagPicker(),
                  SizedBox(height: 10),
                  createButton,
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tagPicker(){
    return FutureBuilder<TagsList>(
      future: loadTags(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          var tags = snapshot.data.tags;
          return ListView.builder(
              shrinkWrap: true,
            itemCount: snapshot.data.tags.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Row(
                      children: [
                       SizedBox(
                         height: 30,
                         child:  Image.network(tags[index].imageURL),
                       ),
                        SizedBox(width: 10),
                        Text(tags[index].name)
                      ],
                    ),
                    value: _checked[index],
                    onChanged: (bool value){
                      _checked[index] = value;
                      if(value == true){
                        _tagIds.add(tags[index].id);
                      } else {
                        _tagIds.remove(tags[index].id);
                      }
                      setState(() {
                      });
                    },
                );
              }
          );
        } else if (snapshot.hasError){
          return ErrorLoading();
        }
        return Loading();
      },
    );
  }

  Widget uploadButton(){
    if(_file != null){
      return  Padding(
        padding: EdgeInsets.only(left: 80, right: 80),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: FittedBox(
              child: Image.file(_file),
          ),
        ),
      );
    }
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
      ),
      onPressed: (){
        chooseImage();
      },
        child: Column(
          children: [
            Text("Upload picture", style: TextStyle(color: Styles.black,
                fontSize: 18))
          ],
        ),
    );
  }

}
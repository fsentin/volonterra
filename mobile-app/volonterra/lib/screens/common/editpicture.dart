import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/components/buttons.dart';
import 'package:http/http.dart' as http;

class EditPictureScreen extends StatefulWidget {
  final int id;
  final bool isVolunteer;

  EditPictureScreen({Key key, @required this.id,
    @required this.isVolunteer}) : super(key: key);

  @override
  _EditPictureScreenState createState() => _EditPictureScreenState();
}

class _EditPictureScreenState extends State<EditPictureScreen> {
  File _file;
  String _base64Image;

  upload() async {
    final vol = '/volunteers/upload-image/';
    final org = '/organizations/upload-image/';
    final api = Routes.BASE + (widget.isVolunteer ? vol : org) + widget.id.toString();


    Map editinfo = {
      'id' : widget.id,
      'image' : _base64Image,
    };

    http.Response response = await http.post(Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Routes.basicAuth
        },
        body:jsonEncode(editinfo));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully edited profile picture!',
              style: GoogleFonts.raleway(),
            ),
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unsuccessfully edited profile picture! Try again. Image might be too large.',
              style: GoogleFonts.raleway(),
            ),
          )
      );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile picture",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child:  Column(
            children: [
              SizedBox(height: 20,),
              uploadButton(),
              image(),
              setButton(),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadButton(){
    if(_file != null){
      return SizedBox(width: 0);
    }
    return WhiteButton(displayedText: "Upload picture",
      onPressed: (){
        chooseImage();
      },
    );
  }

  Widget setButton() {
    if(_file == null){
      return SizedBox(width: 0,);
    }
    return BlackButton(displayedText: "Choose this picture",
        onPressed: (){
          upload();
        }
    );
  }

  Widget image(){
    if(_file == null){
      return SizedBox(width: 0,);
    }
    return Padding(
      padding: EdgeInsets.only(left: 80, right: 80, top: 25, bottom: 25),
      child:  ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.file(_file),
        ),
    );
  }
}
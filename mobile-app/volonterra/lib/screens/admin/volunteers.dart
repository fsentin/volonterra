import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/shared.dart';
import 'package:volonterra/screens/admin/listvolunteersscreen.dart';

class Volunteers extends StatefulWidget {
  @override
  _VolunteersState createState() => _VolunteersState();
}

class _VolunteersState extends State<Volunteers> {

  @override
  Widget build(BuildContext context) {
    return ListVolunteersScreen(
        title: '',
        route: Routes.BASE + '/volunteers/all',
    );
  }
}
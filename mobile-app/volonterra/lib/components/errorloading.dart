import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Not available at the moment.'),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}
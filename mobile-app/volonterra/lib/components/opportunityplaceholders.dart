import 'package:flutter/cupertino.dart';
import 'dart:math';

class OpportunityPlaceholder extends StatelessWidget {
  int generate(int max){
    return Random().nextInt(max);
  }
  final _placeholders = [
    Image.asset('assets/images/placeholder_blue.png',
      fit: BoxFit.fitWidth),
    Image.asset('assets/images/placeholder_gray.png',
        fit: BoxFit.fitWidth),
    Image.asset('assets/images/placeholder_green.png',
        fit: BoxFit.fitWidth),
    Image.asset('assets/images/placeholder_yellow.png',
        fit: BoxFit.fitWidth),
    Image.asset('assets/images/placeholder_red.png',
        fit: BoxFit.fitWidth)
  ];
  
  @override
  Widget build(BuildContext context) {
    return _placeholders[generate(_placeholders.length)];
  }

}
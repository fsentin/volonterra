import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volonterra/styles.dart';

class BlackButton extends StatelessWidget {
  final String displayedText;
  final Function onPressed;

  BlackButton({Key key, @required this.displayedText, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Styles.btnStyleBlack,
      child: Text(displayedText,
        textAlign: TextAlign.center,
        style: Styles.textStyleWhite,
      ),
    );
  }
}


class WhiteButton extends StatelessWidget {
  final String displayedText;
  final Function onPressed;

  WhiteButton({Key key, this.displayedText, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Styles.btnStyleWhite,
      child: Text(displayedText,
        textAlign: TextAlign.center,
        style: Styles.textStyleBlue,
      ),
    );
  }
}

class RedButton extends StatelessWidget {
  final String displayedText;
  final Function onPressed;

  RedButton({Key key, this.displayedText, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Styles.btnStyleRed,
      child: Text(displayedText,
        textAlign: TextAlign.center,
        style: Styles.textStyleWhite,
      ),
    );
  }
}
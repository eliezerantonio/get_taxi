import 'package:flutter/material.dart';

class TaxiButton extends StatelessWidget {
  const TaxiButton({ this.title, this.onPressed, this.color

  });

  final String title;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25),),
      color: color,
      textColor: Colors.white,

      onPressed: onPressed,


      child: Container(
        height: 44,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }}
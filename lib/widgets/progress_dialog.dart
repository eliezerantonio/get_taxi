import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gettaxi/helpers/brand_colors.dart';

class ProgressDialog extends StatelessWidget {

  final String status;
  ProgressDialog({this.status});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 50,
        margin: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              status,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

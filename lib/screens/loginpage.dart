import 'package:flutter/material.dart';
import 'package:gettaxi/helpers/brand_colors.dart';
import 'package:gettaxi/screens/registerpage.dart';
import 'package:gettaxi/widgets/taxibutton.dart';

class LoginPage extends StatelessWidget {
  static const String id="login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(height: 70),
                Image(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  image: AssetImage("images/logo.png"),
                ),
                SizedBox(height: 40),
                Text("Sign In as Rider",
                    style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold')),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 40),
                TaxiButton(title: "LOGIN", color: BrandColors.colorGreen,
                  onPressed: (){

                  },),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, RegisterPage.id,
                            (route) =>
                    false);
                  },
                  child: Text("Don't have an account, sign up here"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



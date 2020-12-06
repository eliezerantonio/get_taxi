import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gettaxi/helpers/brand_colors.dart';
import 'package:gettaxi/screens/register_page.dart';
import 'package:gettaxi/widgets/progress_dialog.dart';
import 'package:gettaxi/widgets/taxi_button.dart';

import 'main_page.dart';

class LoginPage extends StatelessWidget {
  static const String id = "login";

  //Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //TEXT
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void login() async {
      //mostra progress dialog

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              ProgressDialog(status: "Acessando"));
      final FirebaseUser user = (await _auth
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .catchError((onError) {
        //Verificando erro e mostrando message
        Navigator.pop(context);
        PlatformException thisEx = onError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(thisEx.message),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ));
      }))
          .user;

      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.reference().child("users/${user.uid}");

        userRef.once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            //apos verificar, ir para main page
            Navigator.pushNamedAndRemoveUntil(
                context, MainPage.id, (route) => false);
          }
        });
      }
    }

    return Form(
      key: _formKey,
      child: Scaffold(
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
                  Text("Login Motorista",
                      style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold')),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    style: TextStyle(fontSize: 18),
                    validator: (text){
                      if(text.isEmpty||!text.contains("@")){
                        return "email invalido";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    style: TextStyle(fontSize: 18),
                      validator: (text){
                        if(text.length<6){
                          return "Senha invalida";
                        }
                      }
                  ),
                  SizedBox(height: 40),
                  TaxiButton(
                    title: "LOGIN",
                    color: BrandColors.colorGreen,
                    onPressed: () {
                     if(_formKey.currentState.validate()){
                       login();
                     }
                    },
                  ),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RegisterPage.id, (route) => false);
                    },
                    child: Text("Não tem uma conta?, Criar agora"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

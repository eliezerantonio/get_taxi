import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gettaxi/helpers/brand_colors.dart';
import 'package:gettaxi/screens/login_page.dart';
import 'package:gettaxi/screens/main_page.dart';
import 'package:gettaxi/widgets/progress_dialog.dart';
import 'package:gettaxi/widgets/taxi_button.dart';

class RegisterPage extends StatefulWidget {
  //ROUTE ID
  static const String id = "register";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var fullnameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
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
                  Text(
                    "Cadastro Motorista",
                    style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                  ),
                  TextFormField(
                    controller: fullnameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome completo",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    style: TextStyle(fontSize: 18),
                    validator: (text) {
                      if (text.isEmpty || text.length < 3) {
                        return "Digite o nome completo";
                      }
                    },
                  ),
                  TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      style: TextStyle(fontSize: 18),
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@")) {
                          return "Digite e email";
                        }
                      }),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Digite o telefone";
                      }
                    },
                    style: TextStyle(fontSize: 18),
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
                      validator: (text) {
                        if (text.isEmpty || text.length < 6) {
                          return "Digite a senha";
                        }
                      }),
                  SizedBox(height: 40),
                  TaxiButton(
                    title: "Cadastrar",
                    color: BrandColors.colorGreen,
                    onPressed: () async {


                      if (_formKey.currentState.validate()) {
                        registerUser();
                      }
                    },
                  ),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.id, (route) => false);
                    },
                    child: Text("Tem uma conta Motorista? Entrar"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() async {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: "Cadastrando"));

    final FirebaseUser user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
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
    // verifica se o reistro é feito cm successo
    Navigator.pop(context);
    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child("users/${user.uid}");

      //preparando dos dados paraa salvar
      Map userMap = {
        "fullname": fullnameController.text,
        "email": emailController.text,
        "phone": phoneController.text
      };

      newUserRef.set(userMap);

      //apos salvar, ir para main page
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  }
}

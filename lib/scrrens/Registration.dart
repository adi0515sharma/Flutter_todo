import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/Utils/Authentication.dart';
import 'package:task/Utils/Resource.dart';
import 'package:task/Utils/utils.dart';

import 'Home.dart';
import 'Login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _password = "";

  @override
  initState() {
    super.initState();
    // Add listeners to this class
  }

  _launchURL() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  final _formKey = GlobalKey<FormState>();


  regiseterWithEmailAndPassword() async{
    String email = emailController.text;
    String password = passwordController.text;
    Resource<User>? user = await Authentication.createUserWithEmailAndPassword(email, password);
    if(user!=null)
    {
      if(user.status == ResourceStatus.Success){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home()));
      }
      Utils.showToastMessage(user.message, Toast.LENGTH_SHORT);
    }
    else{
      Utils.showToastMessage(Resource.SOMETHING_WENT_WRONG, Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text("Sign Up",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      textStyle: const TextStyle(fontSize: 23))),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(hintText: "Email Id : ", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email id';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => _password = value,
                    autovalidateMode: AutovalidateMode.always,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: "Password : ", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(

                    autovalidateMode: AutovalidateMode.always,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Confirm Password : ",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      }
                      else if(value != _password){
                        return 'Confirm password not matching with password';
                      }
                      return null;
                    },
                  ),
                ],
              )),

              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(0, 17, 0,17))),
                  onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        regiseterWithEmailAndPassword();
                      }
                  },
                  child: Center(
                    child: Text("Sign Up",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            textStyle: const TextStyle(fontSize: 18))),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "already have account ? ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: "SignIn here",
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL();
                    },
                ),
              ]))
            ],
          ),
        ),
      )),
    );
  }
}

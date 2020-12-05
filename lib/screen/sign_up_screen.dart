import 'package:flutter/material.dart';
import 'package:project01_app/helperfunction/authentication.dart';
import 'package:project01_app/screen/RoomOverView%20Screen.dart';
import 'package:project01_app/screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routName = 'sign_upn_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  TextEditingController passWordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> signMeUp() async {
      if (!formKey.currentState.validate()) {
        return;
      } else {
        formKey.currentState.save();
        setState(() {
          isLoading = true;
        });
        await Provider.of<Authentication>(context, listen: false)
            .signUp(emailController.text, passWordController.text);

        setState(() {
          Navigator.pushNamed(context, RoomOverViwScreen.routName);

          isLoading = false;
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    return val.length < 3
                        ? "The username must contain 3 digit"
                        : null;
                  },
                  controller: userNameController,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45)),
                      labelText: "UserName",
                      labelStyle:
                          TextStyle(color: Colors.black45, fontSize: 16)),
                  autocorrect: true,
                ),
                TextFormField(
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.13457'*+-/=?^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Please Provide a valid UserEmail";
                  },
                  controller: emailController,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45)),
                      labelText: "Email",
                      labelStyle:
                          TextStyle(color: Colors.black45, fontSize: 16)),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: true,
                ),
                TextFormField(
                  validator: (val) {
                    return val.length < 6
                        ? "The password must contain 6 digit"
                        : null;
                  },
                  controller: passWordController,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45)),
                      labelText: "Password",
                      labelStyle:
                          TextStyle(color: Colors.black45, fontSize: 16)),
                  obscureText: true,
                  autocorrect: true,
                ),
                GestureDetector(
                  onTap: () {
                    signMeUp();
                  },
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.green,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(colors: [
                                  Colors.lightBlue,
                                  Colors.white,
                                  Colors.red,
                                ])),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: SweepGradient(colors: [
                        Colors.greenAccent,
                        Colors.black,
                        Colors.green,
                      ])),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    "Sign Up With Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, SignInScreen.routName);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                        child: Text(
                          'SignIn now',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

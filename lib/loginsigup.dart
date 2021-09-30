import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebaseauth/forgetpage.dart';
import 'package:flutter_application_firebaseauth/homepage.dart';
import 'package:flutter_application_firebaseauth/restration.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authpage extends StatefulWidget {
  const Authpage({Key? key}) : super(key: key);

  @override
  _AuthpageState createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: t1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: t2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  hintText: 'password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                )),
          ),
          RaisedButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Forgotpass()));
              },
              icon: Icon(Icons.restore_page),
              label: Text("forgot password")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    login();
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();

                    // prefs.setString("email", t1.text);
                    // prefs.setString("password", t2.text);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext ctx) => HomeScreen()));
                  },
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => Regestration()));
                  },
                  child: Text("Register")),
            ],
          ),
          Divider(),
          Text("or"),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: t3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  hintText: 'Enter phone number',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinCodeTextField(
                appContext: context, length: 6, onChanged: (val) {}),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  AuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationID, smsCode: t3.text);
                  sendOtp();
                },
                child: Text("Login")),
          ),
        ],
      )),
    );
  }

  login() async {
    try {
      UserCredential usercred = await _auth.signInWithEmailAndPassword(
          email: t1.text, password: t2.text);
      if (usercred.user!.emailVerified) {
        // print("successfully login");
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
      }
      // print("email not varified");

    } catch (e) {
      SnackBar snk = SnackBar(
        content: Text(
          e.toString(),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snk);
      print("email not varified");
    }
  }

  sendOtp() async {
    print("send otp");
    _auth.verifyPhoneNumber(
        phoneNumber: "+91${t3.text}",
        verificationCompleted: (cred) {
          print("verificationCompleted ${cred.smsCode}");
        },
        verificationFailed: (ex) {
          print("verificationFailed ${ex.message}");
        },
        codeSent: (verificationID, len) {
          this.verificationID = verificationID;

          print("codeSent");
        },
        codeAutoRetrievalTimeout: (timeout) {
          print("codeAutoRetrievalTimeout");
        });
  }
}

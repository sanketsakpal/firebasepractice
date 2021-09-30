import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var msg = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
              ),
              child: Center(
                child: Text(
                  "Login Now",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: t1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: t2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Password"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  msg = "Welcome  ${t1.text}";
                  register();
                });
              },
              child: Text("registration"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  login();
                });
              },
              child: Text("login"),
            ),
            Text(msg),
          ],
        ),
      ),
    ));
  }

  login() async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: t1.text, password: t2.text);

      if (user.user != null) {
        print(user.user!.uid);
        print("isemailvarified${user.user!.emailVerified}");
        //  await _auth.sendPasswordResetEmail(email: t1.text);
      } else {
        print("issuse creating an user ${user}");
      }
    } catch (e) {
      print("exception${e.toString()}");
      SnackBar snk = SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snk);
    }
    // user.user!.uid;
  }

  register() async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: t1.text, password: t2.text);
      if (user.user != null) {
        print(user.user!.uid);
        await user.user!.sendEmailVerification();
      } else {
        print("issuse creating an user ${user}");
      }
    } catch (e) {
      print("exception${e.toString()}");
      // SnackBar snk = SnackBar(content: Text(e.toString()));
      // ScaffoldMessenger.of(context).showSnackBar(snk);
    }
    // user.user!.uid;
  }
}

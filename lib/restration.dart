import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Regestration extends StatefulWidget {
  const Regestration({Key? key}) : super(key: key);

  @override
  _RegestrationState createState() => _RegestrationState();
}

class _RegestrationState extends State<Regestration> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              'Register',
              style: TextStyle(fontSize: 36.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
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
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                )),
          ),
          ElevatedButton(
              onPressed: () {
                registration();
              },
              child: Text("Register Now")),
        ],
      ),
    ));
  }

  registration() async {
    try {
      UserCredential usercred = await _auth.createUserWithEmailAndPassword(
          email: t1.text, password: t2.text);
      if (usercred.user != null) {
        await usercred.user!.sendEmailVerification();
      } else {
        print("issuse creating an user ${usercred}");
      }
    } catch (e) {}
  }
}

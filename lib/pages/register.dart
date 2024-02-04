import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_reddit_2/components/customSnackBar.dart';
import 'package:service_reddit_2/pages/login.dart';
import 'package:service_reddit_2/pages/scroll_calendar.dart';
import 'package:service_reddit_2/utilities/entry_manager.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String output = "";
  final db = FirebaseFirestore.instance;

  Future<void> RegisterAccount() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        setState(() {
          output = 'Passwort zu schwach.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          output = 'Der Account existiert bereits.';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          output = "Das ist keine E-Mail.";
        });
      }
    }
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        output = "Account wurde erstellt";
        
        //TEST
        EntryManager.set_user("Georg Methner", 2004);
        
        Navigator.push(context, MaterialPageRoute(builder: (_) => ScrollCalendar()));
      }
    });
    CustomSnackBar.show(context, output);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 620,
        width: 500,
        padding: const EdgeInsets.only(top: 30, left: 60, right: 57, bottom: 14),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1.5, color: Theme.of(context).colorScheme.outline),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Theme.of(context).colorScheme.outline,
                    endIndent: 10,
                  )),
                  Text(
                    "Registrieren",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Expanded(
                      child: Divider(
                    color: Theme.of(context).colorScheme.outline,
                    indent: 10,
                  )),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                        width: 300,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: RegisterAccount,
                          child: const Text("Sign Up with Google"),
                        )),
                  ),
                  SizedBox(
                      width: 300,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: RegisterAccount,
                        child: const Text("Sign Up with Apple"),
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Theme.of(context).colorScheme.outline,
                    endIndent: 10,
                  )),
                  Text(
                    "oder",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Expanded(
                      child: Divider(
                    color: Theme.of(context).colorScheme.outline,
                    indent: 10,
                  )),
                ],
              ),
              Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text) {
                      email = text;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'E-Mail Adresse',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      onChanged: (text) {
                        password = text;
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Passwort',
                          hintStyle: Theme.of(context).textTheme.bodyLarge),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 2),
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        InkWell(
                          child: const Text("Schon registriert? Log In"),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
                          },
                        ),
                        Text(output)
                      ])),
                  Divider(
                      height: 30,
                      indent: 10,
                      endIndent: 10,
                      color: Theme.of(context).colorScheme.outline),
                  SizedBox(
                    width: 300,
                    height: 35,
                    child: ElevatedButton(
                        onPressed: () {
                          RegisterAccount();
                        },
                        child: const Text("Sign Up")),
                  ),
                ],
              ),
            ]),
      ),
    ));
  }
}

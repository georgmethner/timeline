import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_reddit_2/components/customSnackBar.dart';
import 'package:service_reddit_2/main.dart';
import 'package:service_reddit_2/pages/register.dart';

import '../utilities/entry_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  String output = "";

  Future<void> loginAccount() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          output = 'Account existiert nicht.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          output = 'Das Passwort ist falsch.';
        });
      }
    }
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        output = "Log In erfolgreich.";
        await EntryManager.start();

        Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
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
                    "Log In",
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
                          onPressed: loginAccount,
                          child: const Text("Log In with Google"),
                        )),
                  ),
                  SizedBox(
                      width: 300,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: loginAccount,
                        child: const Text("Log In with Apple"),
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
                          child: const Text("Noch kein Account? Sign Up"),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));
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
                          loginAccount();
                        },
                        child: const Text("Log In")),
                  ),
                ],
              ),
            ]),
      ),
    ));
  }
}

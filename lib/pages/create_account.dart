import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chatter/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Map userData = {"username": "", "bio": ""};

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackbar =
      SnackBar(content: Text("Welcome" + userData["username"] + "!"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, [userData["username"], userData["bio"]]);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context,
          titleText: "Set up your profile", removeBackButton: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "Create a username",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            validator: (val) {
                              if (val.trim().length < 3 || val.isEmpty) {
                                return "Username too short";
                              } else if (val.trim().length > 12) {
                                return "Username too long";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) => userData["username"] = val,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username",
                              labelStyle: TextStyle(fontSize: 15.0),
                              hintText: "Must be at least 3 characters",
                            ),
                          ),
                          Divider(
                            height: 15.0,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val.trim().length < 3 || val.isEmpty) {
                                return "Bio too short";
                              } else if (val.trim().length > 100) {
                                return "Bio too long";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) => userData["bio"] = val,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Bio",
                              labelStyle: TextStyle(fontSize: 15.0),
                              hintText: "Must be at least 3 characters",
                            ),
                          ),
                          Divider(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: submit,
                            child: Container(
                              height: 50.0,
                              width: 350.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

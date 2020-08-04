import 'package:flutter/material.dart';
import 'package:new_firebase/screens/services/auth.dart';
import 'package:new_firebase/screens/shared/input_decoration.dart';
import 'package:new_firebase/screens/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key key, this.toggleView}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("this is Sign in "),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Register"))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              inputDecoration.copyWith(hintText: "Email"),
                          validator: (val) =>
                              val.isEmpty ? "Enter Your Email" : null,
                          onChanged: (val) {
                            setState(() {
                              return email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration:
                              inputDecoration.copyWith(hintText: "Password"),
                          validator: (value) => value.length < 6
                              ? "Enter password 6+ char long"
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              return password = val;
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text("SignIn"),
                          color: Colors.pink[400],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                return loading = true;
                              });
                              dynamic result = await _auth
                                  .signinWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = "please supply a valid email";
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ))),
          );
  }
}

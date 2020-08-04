import 'package:flutter/material.dart';
import 'package:new_firebase/screens/services/auth.dart';
import 'package:new_firebase/screens/shared/input_decoration.dart';
import 'package:new_firebase/screens/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key key, this.toggleView}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  bool loading = false;
  String error = "";
  String email = "";
  String password = "";
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
              title: Text("SignUp to BOMPRO "),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: Text("SignIn"),
                )
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
                          validator: (val) =>
                              val.length < 6 ? "Enter char 6+" : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              return password = val;
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text("Register"),
                          color: Colors.pink[400],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                return loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
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

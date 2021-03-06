import 'package:flutter/material.dart';
import 'package:new_firebase/models/user.dart';
import 'package:new_firebase/screens/authenticate/authenticate.dart';
import 'package:new_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}

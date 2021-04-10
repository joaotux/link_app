import 'package:flutter/material.dart';
import 'package:link_app/model/Token.dart';
import 'package:link_app/utils/shared_utils.dart';

class LoginService {
  Future enterSystem(Token token, BuildContext context) async {
    if (token.token.isNotEmpty) {
      SharedUtils shared = SharedUtils();
      bool ok = await shared.setValueString("token", token.token);

      if (ok) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    }
  }
}

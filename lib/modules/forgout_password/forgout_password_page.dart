import 'package:flutter/material.dart';
import 'package:link_app/modules/forgout_password/forgout_password_repository.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';
import 'package:link_app/utils/widgets/textfiel01.dart';

class ForgoutPasswordPage extends StatefulWidget {
  ForgoutPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgoutPasswordPageState createState() => _ForgoutPasswordPageState();
}

class _ForgoutPasswordPageState extends State<ForgoutPasswordPage> {
  var _emailController = TextEditingController();
  var _repository = ForgoutPasswordRepository();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Future forgoutMyPassword(String email) async {
    String message = await _repository.forgoutMyPassword(email, _scaffoldKey);
    SnackBarDefault.open(scaffoldKey: _scaffoldKey, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField01(
                margin: EdgeInsets.only(bottom: 10),
                controller: _emailController,
                hintText: "Informe o seu e-mail"),
            Button01(
                function: () {
                  String email = _emailController.text;
                  forgoutMyPassword(email);
                },
                title: "Enviar")
          ],
        ),
      ),
    );
  }
}

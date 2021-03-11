import 'package:flutter/material.dart';
import 'package:link_app/model/Token.dart';
import 'package:link_app/modules/home/home_page.dart';
import 'package:link_app/modules/login/login_page.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/keys.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenInitial extends StatefulWidget {
  @override
  _SplashScreenInitialState createState() => _SplashScreenInitialState();
}

class _SplashScreenInitialState extends State<SplashScreenInitial> {
  bool _logged = false;

  _configInitial() async {
    await _isLogged();
  }

  Future _isLogged() async {
    // TokenDAO dao = TokenDAO();
    // Token token = await dao.getToken();
    // if (token != null) {
    //   setState(() {
    //     _logged = true;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    _configInitial();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: _logged ? HomePage() : Login(),
        title: Text(Keys.nameApp,
            style: TextStyle(
                color: Color(ColorsDefault.text1),
                fontSize: 40,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color(ColorsDefault.primary),
        loadingText: Text(
          "By UmDesenvolvedor",
          style: TextStyle(
              fontSize: 15, height: 1, color: Color(ColorsDefault.text1)),
        ),
        photoSize: 100.0,
        loaderColor: Color(ColorsDefault.text1));
  }
}

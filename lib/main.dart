import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_app/modules/app/app.dart';
import 'package:link_app/utils/colors_default.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color(ColorsDefault.primary), // navigation bar color
    statusBarColor: Color(ColorsDefault.primary), // status bar color
  ));

  runApp(App());
}

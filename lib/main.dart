import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/modules/app/app.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/token_utils.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:
        Color(ColorsDefault.primary), // navigation bar color
    statusBarColor: Color(ColorsDefault.primary), // status bar color
  ));

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<TokenUtils>(TokenUtils());
  runApp(App());
}

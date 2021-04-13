import 'package:flutter/material.dart';
import 'package:link_app/model/provider.dart';
import 'package:link_app/modules/account/account_create.dart';
import 'package:link_app/modules/forgout_password/forgout_password_page.dart';
import 'package:link_app/modules/home/home_page.dart';
import 'package:link_app/modules/login/login_page.dart';
import 'package:link_app/modules/product/product_list.dart';
import 'package:link_app/modules/product/product_page.dart';
import 'package:link_app/modules/provider/provider_list.dart';
import 'package:link_app/modules/provider/provider_page.dart';
import 'package:link_app/modules/service/service_list.dart';
import 'package:link_app/modules/service/service_page.dart';
import 'package:link_app/utils/colors_default.dart';

class MaterialAPP extends StatelessWidget {
  const MaterialAPP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        "/account_create": (context) => AccountCreate(),
        "/forgout_password": (context) => ForgoutPasswordPage(),
        "/home": (context) => HomePage(),
        "/product": (context) => ProductList(),
        "/product/form": (context) => ProductPage(),
        "/provider": (context) => ProviderList(),
        "/provider/form": (context) => ProviderPage(),
        "/service": (context) => ServiceList(),
        "/service/form": (context) => ServicePage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(ColorsDefault.primary),
          ),
          primaryColor: Color(ColorsDefault.primary),
          primaryColorDark: Color(ColorsDefault.primaryDark),
          primaryColorLight: Color(ColorsDefault.primaryLight),
          scaffoldBackgroundColor: Colors.white,
          accentColor: Color(ColorsDefault.primary),
          iconTheme: IconThemeData(color: Colors.white),
          primaryIconTheme: IconThemeData(color: Colors.white),
          primaryTextTheme: TextTheme(
              subtitle1: TextStyle(color: Color(ColorsDefault.text1)))),
    );
  }
}

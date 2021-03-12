import 'package:flutter/material.dart';

class NavigatorTo {
  static void to(BuildContext context, String newRouter) {
    String currentRouter = ModalRoute.of(context).settings.name;
    if (currentRouter != newRouter) Navigator.pushNamed(context, newRouter);
  }
}

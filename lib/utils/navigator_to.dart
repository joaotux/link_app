import 'package:flutter/material.dart';

class NavigatorTo {
  static Future to(BuildContext context, String newRouter) async {
    String currentRouter = ModalRoute.of(context)!.settings.name!;
    if (currentRouter != newRouter)
      await Navigator.pushNamed(context, newRouter);
    return Future.value();
  }
}

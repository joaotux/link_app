import 'package:flutter/material.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/shared_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = "";

  _getToke() async {
    SharedUtils shared = SharedUtils();
    token = await shared.getValueString("token");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getToke();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBarMenu(),
          body: Container(
            child: Text("Token é $token"),
          ),
        ));
  }
}

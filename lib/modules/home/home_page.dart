import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/utils/token_utils.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/shared_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tokenUtils = GetIt.I.get<TokenUtils>();
  String token = "";

  _getToke() async {
    SharedUtils shared = SharedUtils();
    token = await shared.getValueString("token");
    tokenUtils.token = token;

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

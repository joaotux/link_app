import 'package:flutter/material.dart';
import 'package:link_app/utils/navigator_to.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';

class AppBarMenu extends StatefulWidget with PreferredSizeWidget {
  AppBarMenu({Key? key}) : super(key: key);

  @override
  _AppBarMenuState createState() => _AppBarMenuState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarMenuState extends State<AppBarMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      leadingWidth: 150,
      leading: Center(
        child: Text("Link Gestão",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      title: ResponsiveLayout.isLargeScreen(context)
          ? menuRow(context)
          : Container(),
      actions: ResponsiveLayout.isLargeScreen(context)
          ? actionsList()
          : [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.menu),
              )
            ],
    );
  }

  List<Widget> actionsList() {
    return [
      Container(
          margin: EdgeInsets.only(right: 15),
          child: IconButton(
              icon: Icon(Icons.supervised_user_circle), onPressed: () {})),
      Container(
          margin: EdgeInsets.only(right: 15),
          child: IconButton(icon: Icon(Icons.settings), onPressed: () {})),
      Container(
        margin: EdgeInsets.only(right: 15, left: 10),
        child: TextButton(
            onPressed: () {},
            child: Text("Relatórios",
                style: TextStyle(color: Colors.white, fontSize: 16))),
      )
    ];
  }

  Row menuRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: TextButton(
              onPressed: () {
                NavigatorTo.to(context, "/home");
              },
              child: Text("Visão Geral",
                  style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: ButtonTheme(
              alignedDropdown: true,
              padding: EdgeInsets.zero,
              child: DropdownButton(
                  dropdownColor: Colors.orange,
                  elevation: 0,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  underline: Container(),
                  hint: Text("Cadastros",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  items: [
                    DropdownMenuItem(
                      value: "/product",
                      child: Text("Produto",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    DropdownMenuItem(
                      value: "/provider",
                      child: Text("Fornecedor",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    DropdownMenuItem(
                      value: "/service",
                      child: Text("Serviços",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ],
                  onChanged: (value) {
                    NavigatorTo.to(context, value.toString());
                  })),
        ),
      ],
    );
  }
}

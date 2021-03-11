import 'package:flutter/material.dart';

class AppBarMenu extends StatefulWidget with PreferredSizeWidget {
  AppBarMenu({Key key}) : super(key: key);

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
        child: Text("Gestão Link",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {},
                child: Text("Visão Geral",
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {},
                child: Text("Vendas",
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
                    value: 1,
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          "Venda",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Venda 1",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onTap: () {
                          print("Vanda 1");
                        },
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Venda 2",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onTap: () {
                          print("Venda 2");
                        },
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("Venda 3",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onTap: () {
                          print("Venda 3");
                        },
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {});
                    })),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {},
                child: Text("Financeiro",
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {},
                child: Text("Cadastros",
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {},
                child: Text("Ajuda",
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
        ],
      ),
      actions: [
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
      ],
    );
  }
}

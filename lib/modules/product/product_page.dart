import 'package:flutter/material.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/textfiel01.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(),
      body: Center(
        child: Container(
          width: (MediaQuery.of(context).size.width * 50) / 100,
          color: Colors.yellow,
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Nome do produto:"),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  child: TextField01(controller: null, hintText: "")),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Código do produto:"),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            width:
                                (MediaQuery.of(context).size.width * 8) / 100,
                            child: TextField01(controller: null, hintText: "")),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Código de barra (EAN):"),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            width:
                                (MediaQuery.of(context).size.width * 20) / 100,
                            child: TextField01(controller: null, hintText: "")),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Categoria do produto:"),
                        Container(
                            width:
                                (MediaQuery.of(context).size.width * 10) / 100,
                            child: TextField01(controller: null, hintText: "")),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Valor venda:"),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            width:
                                (MediaQuery.of(context).size.width * 8) / 100,
                            child: TextField01(controller: null, hintText: "")),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Custo médio:"),
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            width:
                                (MediaQuery.of(context).size.width * 8) / 100,
                            child: TextField01(controller: null, hintText: "")),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

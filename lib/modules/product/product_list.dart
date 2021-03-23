import 'package:flutter/material.dart';
import 'package:link_app/model/product/product.dart';
import 'package:link_app/model/provider.dart';
import 'package:link_app/modules/product/product_repository.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/textfiel01.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
                width: 500,
                child: TextField01(
                    controller: null, hintText: "Descrição do produto")),
            FutureBuilder<List<Product>>(
              future: _list(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return Expanded(
                          child: Container(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Product product = snapshot.data[index];
                              return ListTile(
                                title: Text("${product.description}"),
                                onTap: () => {
                                  Navigator.pushNamed(context, "/product/form",
                                      arguments: product.id)
                                },
                              );
                            }),
                      ));
                    } else {
                      return Center(
                        child: Text("Nenhum produto encontrado"),
                      );
                    }
                    break;
                }
                return Text("");
              },
            )
          ],
        ),
      ),
    );
  }

  Future<List<Product>> _list() async {
    List<Product> list = await _repository.list();
    return list;
  }

  var _repository = ProductRepository();
}

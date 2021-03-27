import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:link_app/model/product/product.dart';
import 'package:link_app/modules/product/product_repository.dart';
import 'package:link_app/modules/store/pageable_controller.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/navigator_to.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/pageable_defaul.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/textfiel01.dart';
import 'package:tuple/tuple.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(),
      body: Padding(
        padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: ResponsiveLayout.isSmallScreen(context)
                ? 15
                : MediaQuery.of(context).size.width * 20 / 100,
            right: ResponsiveLayout.isSmallScreen(context)
                ? 15
                : MediaQuery.of(context).size.width * 20 / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 12,
                        child: TextField01(
                          controller: _queryController,
                          hintText:
                              "Descrição, código produto ou código de barras",
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        child: Icon(
                          Icons.search,
                          size: 35,
                          color: Color(ColorsDefault.primary),
                        ),
                        onTap: () {
                          _pageable.setCurrentPage(0);
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Button01(
                width: 80,
                height: 30,
                function: () {
                  NavigatorTo.to(context, "/product/form");
                },
                title: "Novo",
              ),
            ),
            Expanded(
                child: Container(
              child: Observer(
                  builder: (_) => FutureBuilder<List<Product>>(
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
                                return Container(
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Product product = snapshot.data![index];
                                        return ListTile(
                                          title: Text("${product.description}"),
                                          onTap: () async {
                                            await Navigator.pushNamed(
                                                context, "/product/form",
                                                arguments: product.id);
                                            setState(() {});
                                          },
                                        );
                                      }),
                                );
                              } else {
                                return Center(
                                  child: Text("Nenhum produto encontrado"),
                                );
                              }
                              break;
                          }
                          return Text("");
                        },
                      )),
            )),
            PageableDefault(
              pageableController: _pageable,
            ),
          ],
        ),
      ),
    );
  }

  PageableController _pageable = PageableController();
  Future<List<Product>> _list() async {
    String query = _queryController.text;
    Tuple2 tuple = await _repository.list(query, _pageable.currentPage);
    List<Product> list = tuple.item1;
    _pageable.setPageable(tuple.item2);
    return list;
  }

  var _repository = ProductRepository();
  var _queryController = TextEditingController();
}

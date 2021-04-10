import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:link_app/modules/provider/provider_dto.dart';
import 'package:link_app/modules/provider/provider_repository.dart';
import 'package:link_app/modules/store/pageable_controller.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/navigator_to.dart';
import 'package:link_app/utils/widgets/alert_dialog_defaul.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/edit_and_remove.dart';
import 'package:link_app/utils/widgets/pageable_defaul.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/textfiel01.dart';
import 'package:tuple/tuple.dart';

class ProviderList extends StatefulWidget {
  ProviderList({Key? key}) : super(key: key);

  @override
  _ProviderListState createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
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
                child: _searcher(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Button01(
                width: 80,
                height: 30,
                function: () async {
                  await NavigatorTo.to(context, "/provider/form");
                  setState(() {});
                },
                title: "Novo",
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Observer(
                  builder: (_) => FutureBuilder<List<ProviderDTO>>(
                        future: _list(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                return Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        ProviderDTO provider =
                                            snapshot.data![index];
                                        return Container(
                                          color: Color(0xFFf2f2f2),
                                          margin: EdgeInsets.only(bottom: 2),
                                          child: ListTile(
                                            title: Text("${provider.name}"),
                                            trailing: EditAndRemove(
                                              functionEdit: () async {
                                                await Navigator.pushNamed(
                                                    context, "/provider/form",
                                                    arguments: provider.id);
                                                setState(() {});
                                              },
                                              functionRemove: () {
                                                AlertDialogDefault.show(
                                                    context: context,
                                                    title: "Alerta",
                                                    message:
                                                        "Deseja mesmo remover este registro?",
                                                    function: () async {
                                                      await _repository.delete(
                                                          provider.id, _key);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    });
                                              },
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              } else {
                                return Center(
                                  child: Text("Nenhum fornecedor encontrado"),
                                );
                              }
                          }
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

  Row _searcher() {
    return Row(
      children: [
        Expanded(
            flex: 10,
            child: TextField01(
              margin: EdgeInsets.only(right: 15),
              controller: _queryController,
              hintText: "Nome ou CNPJ/CPF",
            )),
        Row(
          children: [
            Text("Ativos: "),
            Checkbox(
                value: _active,
                onChanged: (value) {
                  setState(() {
                    _active = value!;
                  });
                })
          ],
        ),
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
    );
  }

  var _key = GlobalKey<ScaffoldState>();
  PageableController _pageable = PageableController();
  Future<List<ProviderDTO>> _list() async {
    String query = _queryController.text;
    Tuple2 tuple =
        await _repository.listPage(query, _active, _pageable.currentPage, _key);
    List<ProviderDTO> list = tuple.item1;
    _pageable.setPageable(tuple.item2);
    return list;
  }

  var _repository = ProviderRepository();
  var _queryController = TextEditingController();
  bool _active = true;
}

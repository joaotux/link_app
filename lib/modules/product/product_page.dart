import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:link_app/model/product/product.dart';
import 'package:link_app/model/product/product_category.dart';
import 'package:link_app/model/product/product_stock.dart';
import 'package:link_app/model/provider.dart';
import 'package:link_app/modules/product/product_repository.dart';
import 'package:link_app/modules/product_category/product_category_repository.dart';
import 'package:link_app/modules/provider/provider_repository.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/number_format.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/field_form_with_description.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';

class ProductPage extends StatefulWidget {
  int id;
  ProductPage({Key key, this.id}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _find();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBarMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: _loaderPage
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  width: _width(context, 50),
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
                          child: TextFormField01(
                              controller: _descriptionController,
                              hintText: "")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FieldFormWithDescription(
                            controller: _codeController,
                            width: _width(context, 8),
                            description: "Código do produto:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                          FieldFormWithDescription(
                            controller: _barCodeController,
                            width: _width(context, 20),
                            description: "Código de barra (EAN):",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Categoria do produto"),
                              Container(
                                width: 180,
                                margin: EdgeInsets.only(bottom: 10),
                                child: ButtonTheme(
                                    alignedDropdown: true,
                                    padding: EdgeInsets.zero,
                                    child: DropdownButtonHideUnderline(
                                        child: Container(
                                      margin: EdgeInsets.only(bottom: 6),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                      child: FutureBuilder(
                                        future: _listCategories(),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.active:
                                            case ConnectionState.none:
                                            case ConnectionState.waiting:
                                              return CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                              );
                                              break;
                                            case ConnectionState.done:
                                              if (snapshot.hasData) {
                                                return DropdownButton<
                                                        ProductCategory>(
                                                    isExpanded: true,
                                                    elevation: 0,
                                                    icon: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                    ),
                                                    underline: Container(),
                                                    hint: Text(
                                                        "Seleciona uma categoria"),
                                                    value: _category,
                                                    items: snapshot.data.map<
                                                            DropdownMenuItem<
                                                                ProductCategory>>(
                                                        (ProductCategory pc) {
                                                      return DropdownMenuItem<
                                                              ProductCategory>(
                                                          value: pc,
                                                          child: Text(
                                                              pc.description));
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _category = value;
                                                      });
                                                    });
                                              }
                                              break;
                                          }
                                          return Container(
                                            child: Text(""),
                                            height: 30,
                                          );
                                        },
                                      ),
                                    ))),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FieldFormWithDescription(
                            controller: _salesController,
                            width: _width(context, 8),
                            description: "Valor venda:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                          FieldFormWithDescription(
                            controller: _costController,
                            width: _width(context, 8),
                            description: "Custo médio:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FieldFormWithDescription(
                            controller: _stockCurrentController,
                            width: _width(context, 8),
                            description: "Estoque disponível:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                          FieldFormWithDescription(
                            controller: _stockMinController,
                            width: _width(context, 8),
                            description: "Estoque mínimo:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                          FieldFormWithDescription(
                            controller: _stockMaxController,
                            width: _width(context, 8),
                            description: "Estoque máximo:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: FieldFormWithDescription(
                          controller: _noteController,
                          width: _width(context, 100),
                          description: "Observação:",
                          maxLines: 3,
                        ),
                      ),
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              seeProvider = !seeProvider;
                            });
                          },
                          icon: seeProvider
                              ? Icon(
                                  Icons.visibility,
                                  color: Color(ColorsDefault.primary),
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Color(ColorsDefault.primary),
                                ),
                          label: Text(
                            "Fornecedor deste produto",
                            style: TextStyle(
                              color: Color(ColorsDefault.primary),
                            ),
                          )),
                      Visibility(
                          visible: seeProvider,
                          child: Container(
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _nameController,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder())),
                              suggestionsCallback: (pattern) async {
                                if (pattern.isNotEmpty)
                                  return await _providerRepository.list(
                                      pattern, _key);
                              },
                              itemBuilder: (context, suggestion) {
                                Provider p = suggestion;
                                return ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(p.name),
                                  subtitle: Text('test'),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                Provider p = suggestion;
                                _nameController.text = p.name;
                                _privider = p;
                              },
                            ),
                          ))
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Color(0xFFd9d9d9),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 150,
                child: Button01(
                    loader: _loaderCreate,
                    function: () async {
                      String description = _descriptionController.text;
                      String code = _codeController.text;
                      String barCode = _barCodeController.text;
                      num sales = MoneyFormat.parse(_salesController.text);
                      num cost = MoneyFormat.parse(_costController.text);
                      num stockCurrent =
                          MoneyFormat.parse(_stockCurrentController.text);
                      num stockMin =
                          MoneyFormat.parse(_stockMinController.text);
                      num stockMax =
                          MoneyFormat.parse(_stockMaxController.text);
                      String note = _noteController.text;

                      ProductStock stoke = ProductStock(
                        amount: stockCurrent,
                        min: stockMin,
                        max: stockMax,
                        description: "",
                      );

                      Product product = Product(
                          id: _id,
                          description: description,
                          code: code,
                          barCode: barCode,
                          priceSales: sales,
                          priceCost: cost,
                          note: note,
                          category: _category,
                          provider: _privider,
                          stocks: [stoke]);
                      setState(() {
                        _loaderCreate = true;
                      });
                      _create(product);
                    },
                    title: "Salvar")),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              width: 250,
              child: Button01(
                function: () {},
                title: "Salvar e adicionar outro",
                color: Color(0xFFf2f2f2),
                colorText: Color(0xFF1a1a1a),
              ),
            ),
            Container(
              width: 150,
              child: Button01(
                function: () {},
                title: "Listar",
                color: Color(0xFFf2f2f2),
                colorText: Color(0xFF0C66BB),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var _nameController = TextEditingController();
  Provider _privider;
  bool _loaderCreate = false;
  bool _loaderPage = true;
  bool seeProvider = false;
  var _id;
  var _descriptionController = TextEditingController();
  var _codeController = TextEditingController();
  var _barCodeController = TextEditingController();
  var _salesController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");
  var _costController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");
  var _stockCurrentController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");
  var _stockMaxController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");
  var _stockMinController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");
  var _noteController = TextEditingController();

  var _repository = ProductRepository();
  var _prodCatRepository = ProductCategoryRepository();
  var _providerRepository = ProviderRepository();
  var _key = GlobalKey<ScaffoldState>();

  List<ProductCategory> _categories;
  ProductCategory _category;

  double _width(BuildContext context, double porcent) {
    return (MediaQuery.of(context).size.width * porcent) / 100;
  }

  _create(Product product) async {
    if (_loaderCreate) {
      product = await _repository.create(product, _key);
      setState(() {
        _loaderCreate = false;
      });
    }
  }

  Future _find() async {
    var id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      Product product = await _repository.find(id);
      await _listCategories();
      _loadDatas(product);
    }
  }

  Future<List<ProductCategory>> _listCategories() async {
    if (_categories == null) {
      _categories = await _prodCatRepository.list();
    }
    return Future.value(_categories);
  }

  _loadDatas(Product product) {
    _descriptionController.text = product.description;
    _codeController.text = product.code;
    _barCodeController.text = product.barCode;
    _salesController.text = MoneyFormat.format(product.priceSales);
    _costController.text = MoneyFormat.format(product.priceCost);

    double amount = product.stocks.elementAt(0).amount;
    double max = product.stocks.elementAt(0).max;
    double min = product.stocks.elementAt(0).min;

    _stockCurrentController.text = MoneyFormat.format(amount);
    _stockMaxController.text = MoneyFormat.format(max);
    _stockMinController.text = MoneyFormat.format(min);
    _noteController.text = product.note;

    _privider = product.provider;
    _nameController.text = product.provider.name;

    for (var cat in _categories) {
      if (product.category != null && cat.id == product.category.id)
        _category = cat;
    }

    setState(() {
      _loaderPage = false;
    });
  }
}

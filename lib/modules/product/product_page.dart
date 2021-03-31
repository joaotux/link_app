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
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';

class ProductPage extends StatefulWidget {
  int? id;
  ProductPage({Key? key, this.id}) : super(key: key);

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
        child: _loaderPage
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
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
                            mandatory: true,
                            controller: _descriptionController,
                            hintText: "")),
                    Wrap(
                      children: [
                        Container(
                          width: 150,
                          child: FieldFormWithDescription(
                            controller: _codeController,
                            description: "Código do produto:",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                        ),
                        Container(
                          width: 400,
                          child: FieldFormWithDescription(
                            controller: _barCodeController,
                            description: "Código de barra (EAN):",
                            margin: EdgeInsets.only(right: 15, bottom: 15),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Categoria do produto",
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
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
                                      child:
                                          FutureBuilder<List<ProductCategory>>(
                                        future: _listCategories(),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.active:
                                            case ConnectionState.none:
                                            case ConnectionState.waiting:
                                              return CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                              );
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
                                                    items: snapshot.data!.map<
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
                                                        _category = value!;
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
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: FieldFormWithDescription(
                              controller: _salesController,
                              description: "Valor venda:",
                              margin: EdgeInsets.only(right: 15, bottom: 15),
                            )),
                        Expanded(
                            flex: 2,
                            child: FieldFormWithDescription(
                                controller: _costController,
                                description: "Custo médio:",
                                margin: EdgeInsets.only(bottom: 15))),
                        if (ResponsiveLayout.isLargeScreen(context))
                          Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                              ))
                      ],
                    ),
                    Wrap(
                      children: [
                        Container(
                          width: 150,
                          child: FieldFormWithDescription(
                            controller: _stockCurrentController,
                            description: "Estoque disponível:",
                            margin: EdgeInsets.only(right: 15),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: FieldFormWithDescription(
                            controller: _stockMinController,
                            description: "Estoque mínimo:",
                            margin: EdgeInsets.only(right: 15),
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(
                              top: ResponsiveLayout.isSmallScreen(context)
                                  ? 15
                                  : 0),
                          child: FieldFormWithDescription(
                            controller: _stockMaxController,
                            description: "Estoque máximo:",
                            margin: EdgeInsets.only(
                              right: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
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
                              return await _providerRepository.list(
                                  pattern, true, _key);
                            },
                            itemBuilder: (context, suggestion) {
                              Provider? p = suggestion as Provider;
                              return ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(p.person!.name));
                            },
                            onSuggestionSelected: (suggestion) {
                              Provider? p = suggestion as Provider;
                              _nameController.text = p.person!.name;
                              _provider = p;
                            },
                          ),
                        ))
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Color(0xFFd9d9d9),
        height: 80,
        child: Padding(
          padding: EdgeInsets.only(
              left: ResponsiveLayout.isSmallScreen(context)
                  ? 15
                  : MediaQuery.of(context).size.width * 20 / 100,
              right: ResponsiveLayout.isSmallScreen(context)
                  ? 15
                  : MediaQuery.of(context).size.width * 20 / 100),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Button01(
                        loader: _loaderCreate,
                        function: () async {
                          Product product = _getDatas();
                          setState(() {
                            _loaderCreate = true;
                          });
                          _create(product);
                        },
                        title: "Salvar"),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Button01(
                      function: () async {
                        Product product = _getDatas();
                        setState(() {
                          _loaderCreate = true;
                        });
                        product = await _create(product);

                        if (product.id != null) _cleanDatas();
                      },
                      title: "Salvar e adicionar outro",
                      color: Color(0xFFf2f2f2),
                      colorText: Color(0xFF1a1a1a),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Button01(
                    function: () {
                      Navigator.pop(context);
                    },
                    title: "Listar",
                    color: Color(0xFFf2f2f2),
                    colorText: Color(0xFF0C66BB),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Product _getDatas() {
    String description = _descriptionController.text;
    String code = _codeController.text;
    String barCode = _barCodeController.text;
    num sales = MoneyFormat.parse(_salesController.text);
    num cost = MoneyFormat.parse(_costController.text);
    num stockCurrent = MoneyFormat.parse(_stockCurrentController.text);
    num stockMin = MoneyFormat.parse(_stockMinController.text);
    num stockMax = MoneyFormat.parse(_stockMaxController.text);
    String note = _noteController.text;

    ProductStock stoke = ProductStock(
      id: _idStock,
      amount: stockCurrent.toDouble(),
      min: stockMin.toDouble(),
      max: stockMax.toDouble(),
      description: "",
    );

    Product product = Product(
        id: _id,
        description: description,
        code: code,
        barCode: barCode,
        priceSales: sales.toDouble(),
        priceCost: cost.toDouble(),
        note: note,
        category: _category,
        provider: _provider,
        stocks: [stoke]);
    return product;
  }

  _cleanDatas() {
    _id = null;
    _idStock = null;
    _descriptionController.clear();
    _codeController.clear();
    _barCodeController.clear();
    _category = null;
    _salesController.text = "0.0";
    _costController.text = "0.0";
    _stockCurrentController.text = "0.0";
    _stockMaxController.text = "0.0";
    _stockMinController.text = "0.0";
    _noteController.clear();
    _provider = null;
    _nameController.clear();
  }

  var _nameController = TextEditingController();
  Provider? _provider;
  bool _loaderCreate = false;
  bool _loaderPage = true;
  bool seeProvider = false;
  var _id;
  var _idStock;
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

  List<ProductCategory> _categories = [];
  ProductCategory? _category;

  double _width(BuildContext context, double porcent) {
    return (MediaQuery.of(context).size.width * porcent) / 100;
  }

  Future<Product> _create(Product product) async {
    if (_loaderCreate) {
      product = await _repository.create(product, _key);
      setState(() {
        _loaderCreate = false;
      });
    }
    return Future.value(product);
  }

  Future _find() async {
    _id = ModalRoute.of(context)!.settings.arguments;
    if (_id != null) {
      Product product = await _repository.find(_id);
      _idStock = product.stocks!.elementAt(0).id;
      await _listCategories();
      _loadDatas(product);
    }
    setState(() {
      _loaderPage = false;
    });
  }

  Future<List<ProductCategory>> _listCategories() async {
    if (_categories.length == 0) {
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

    double amount = product.stocks!.elementAt(0).amount;
    double max = product.stocks!.elementAt(0).max;
    double min = product.stocks!.elementAt(0).min;

    _stockCurrentController.text = MoneyFormat.format(amount);
    _stockMaxController.text = MoneyFormat.format(max);
    _stockMinController.text = MoneyFormat.format(min);
    _noteController.text = product.note;

    _provider = product.provider;
    _nameController.text =
        product.provider != null ? product.provider!.person!.name : "";

    for (var cat in _categories) {
      if (product.category != null && cat.id == product.category!.id)
        _category = cat;
    }
  }
}

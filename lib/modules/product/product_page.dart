import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:link_app/model/product/product.dart';
import 'package:link_app/model/product/product_category.dart';
import 'package:link_app/model/product/product_stock.dart';
import 'package:link_app/modules/product/product_repository.dart';
import 'package:link_app/modules/product_category/product_category_repository.dart';
import 'package:link_app/utils/number_format.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/field_form_with_description.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

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
var _key = GlobalKey<ScaffoldState>();

List<ProductCategory> _categories;
ProductCategory _category;

double _width(BuildContext context, double porcent) {
  return (MediaQuery.of(context).size.width * porcent) / 100;
}

_create(Product product) async {
  product = await _repository.create(product, _key);
}

Future<List<ProductCategory>> _listCategories() async {
  print("passei aqui ==============");
  if (_categories == null) {
    _categories = await _prodCatRepository.list();
    if (_categories.isNotEmpty) _category = _categories.elementAt(0);
  }

  return Future.value(_categories);
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBarMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
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
                        controller: _descriptionController, hintText: "")),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                child: FutureBuilder(
                                  future: _listCategories(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.active:
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
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
                                                    child:
                                                        Text(pc.description));
                                              }).toList(),
                                              onChanged: (value) {
                                                print(
                                                    "value ============ ${value.description}");
                                                setState(() {
                                                  _category = value;
                                                });
                                              });
                                        }
                                        break;
                                    }
                                    return Text("");
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
                FieldFormWithDescription(
                  controller: _noteController,
                  width: _width(context, 100),
                  description: "Observação:",
                  maxLines: 3,
                ),
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
                          stocks: [stoke]);
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
}

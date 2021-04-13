import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:link_app/model/service.dart';
import 'package:link_app/modules/service/service_repository.dart';
import 'package:link_app/modules/store/app_bar_menu.dart';
import 'package:link_app/utils/number_format.dart';
import 'package:link_app/utils/widgets/bottom_menu_three_button.dart';
import 'package:link_app/utils/widgets/field_form_with_description.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';

class ServicePage extends StatefulWidget {
  int? id;
  ServicePage({Key? key, this.id}) : super(key: key);

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
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
                child: Form(
                    key: _keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Descrição:"),
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
                              hintText: "",
                              mandatory: true,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "Descrição é obrigatória";
                                }
                                return null;
                              },
                            )),
                        Container(
                          child: FieldFormWithDescription(
                            controller: _codeController,
                            description: "Código interno:",
                            margin: EdgeInsets.only(bottom: 15),
                          ),
                        ),
                        Row(
                          children: [
                            Text("Ativo: "),
                            Container(
                              child: Checkbox(
                                value: _active,
                                onChanged: (value) {
                                  setState(() {
                                    _active = !_active;
                                  });
                                },
                              ),
                            ),
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
                                  margin:
                                      EdgeInsets.only(right: 15, bottom: 15),
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
                      ],
                    )),
              ),
      ),
      bottomNavigationBar: BottomMenuThreeButton(
        loaderCreate: _loaderCreate,
        functionSave: () async {
          if (_keyForm.currentState!.validate()) {
            Service service = _getDatas();
            setState(() {
              _loaderCreate = true;
            });
            if (_id == null)
              _create(service);
            else
              _alter(_id, service);
          }
        },
        functionSaveAndCreateNew: () async {
          Service service = _getDatas();
          setState(() {
            _loaderCreate = true;
          });
          service = await _create(service);

          if (service.id != null) _cleanDatas();
        },
      ),
    );
  }

  Service _getDatas() {
    String description = _descriptionController.text;
    String code = _codeController.text;
    num sales = MoneyFormat.parse(_salesController.text);
    num cost = MoneyFormat.parse(_costController.text);

    Service service = Service(
        id: _id,
        description: description,
        code: code,
        priceSales: sales.toDouble(),
        priceCost: cost.toDouble());
    return service;
  }

  _cleanDatas() {
    _id = null;
    _descriptionController.clear();
    _codeController.clear();
    _salesController.text = '0.0';
    _costController.text = '0.0';
  }

  bool _loaderCreate = false;
  bool _loaderPage = true;
  var _id;
  var _active = true;
  var _descriptionController = TextEditingController();
  var _codeController = TextEditingController();
  var _salesController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");
  var _costController =
      MoneyMaskedTextController(decimalSeparator: ",", thousandSeparator: ".");

  var _repository = ServiceRepository();
  var _key = GlobalKey<ScaffoldState>();
  var _keyForm = GlobalKey<FormState>();

  Future<Service> _create(Service service) async {
    if (_loaderCreate) {
      service = await _repository.create(service, _key);
      _id = service.id;
      _loadDatas(service);
      setState(() {
        _loaderCreate = false;
      });
    }
    return Future.value(service);
  }

  Future<Service> _alter(int id, Service service) async {
    if (_loaderCreate) {
      service = await _repository.alter(id, service, _key);
      setState(() {
        _loaderCreate = false;
      });
    }
    return Future.value(service);
  }

  Future _find() async {
    _id = ModalRoute.of(context)!.settings.arguments;
    if (_id != null) {
      Service service = await _repository.find(_id, _key);
      _loadDatas(service);
    }
    setState(() {
      _loaderPage = false;
    });
  }

  _loadDatas(Service service) {
    _descriptionController.text = service.description;
    _codeController.text = service.code;
    _salesController.text = MoneyFormat.format(service.priceSales);
    _costController.text = MoneyFormat.format(service.priceCost);
    _active = service.active;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:link_app/model/person/address.dart';
import 'package:link_app/model/person/city.dart';
import 'package:link_app/model/person/person.dart';
import 'package:link_app/model/person/phone.dart';
import 'package:link_app/model/person/states.dart';
import 'package:link_app/model/provider.dart';
import 'package:link_app/model/receita_ws.dart';
import 'package:link_app/modules/city/city_repository.dart';
import 'package:link_app/modules/provider/provider_repository.dart';
import 'package:link_app/modules/receita_ws/receita_ws_repository.dart';
import 'package:link_app/modules/state/state_repository.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/app_bar_menu.dart';
import 'package:link_app/utils/widgets/bottom_menu_three_button.dart';
import 'package:link_app/utils/widgets/button01.dart';
import 'package:link_app/utils/widgets/field_form_with_description.dart';
import 'package:link_app/utils/widgets/responsive_layout.dart';
import 'package:link_app/utils/widgets/tex_form_fiel01.dart';

class ProviderPage extends StatefulWidget {
  int? id;
  ProviderPage({Key? key, this.id}) : super(key: key);

  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _alterMask();
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
                            Text("Nome do fornecedor:"),
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
                              controller: _nameController,
                              hintText: "",
                              mandatory: true,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "Nome é obrigatório";
                                }
                                return null;
                              },
                            )),
                        Container(
                          child: FieldFormWithDescription(
                            controller: _fantasyNameController,
                            description: "Nome fantásia:",
                            margin: EdgeInsets.only(bottom: 15),
                          ),
                        ),
                        Wrap(
                          children: [
                            Container(
                              width: 300,
                              child: FieldFormWithDescription(
                                controller: _cpfCnpjController,
                                description: "CPF/CNPJ:",
                                margin: EdgeInsets.only(right: 8, bottom: 15),
                              ),
                            ),
                            Container(
                              width: 180,
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  top: ResponsiveLayout.isLargeScreen(context)
                                      ? 25
                                      : 0),
                              child: TextButton.icon(
                                  onPressed: () {
                                    var cnpj = _cpfCnpjController.text
                                        .replaceAll(RegExp('\\D'), '');
                                    if (cnpj.length == 14) {
                                      _findCnpj(cnpj);
                                    }
                                  },
                                  icon: Icon(Icons.search),
                                  label: Text("Buscar dados CNPJ")),
                            )
                          ],
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
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _seeAddress = !_seeAddress;
                                });
                              },
                              icon: _seeAddress
                                  ? Icon(
                                      Icons.visibility,
                                      color: Color(ColorsDefault.primary),
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Color(ColorsDefault.primary),
                                    ),
                              label: Text(
                                "Endereço",
                                style: TextStyle(
                                  color: Color(ColorsDefault.primary),
                                ),
                              )),
                        ),
                        Visibility(
                            visible: _seeAddress,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: FieldFormWithDescription(
                                        controller: _streetController,
                                        description: "Rua:",
                                        margin: EdgeInsets.only(bottom: 15))),
                                Wrap(
                                  children: [
                                    Container(
                                        child: FieldFormWithDescription(
                                            width: 300,
                                            controller: _districtController,
                                            description: "Bairro:",
                                            margin: EdgeInsets.only(
                                                right: 15, bottom: 15))),
                                    Container(
                                        child: FieldFormWithDescription(
                                            width: 300,
                                            controller: _zipCodeController,
                                            description: "CEP:",
                                            margin: EdgeInsets.only(
                                                right: 15, bottom: 15))),
                                    Container(
                                        child: FieldFormWithDescription(
                                            width: 120,
                                            controller: _numberController,
                                            description: "Número:",
                                            margin:
                                                EdgeInsets.only(bottom: 15))),
                                  ],
                                ),
                                Container(
                                    child: FieldFormWithDescription(
                                        controller: _infoController,
                                        description: "Referência:",
                                        margin: EdgeInsets.only(bottom: 15))),
                                Wrap(
                                  children: [
                                    Container(
                                      width: 250,
                                      margin: EdgeInsets.only(
                                          bottom: 15, right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Estado:"),
                                          TypeAheadField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                                    controller:
                                                        _stateNameController,
                                                    autofocus: false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder())),
                                            suggestionsCallback:
                                                (pattern) async {
                                              return await _stateRepository
                                                  .list(pattern, _key);
                                            },
                                            itemBuilder: (context, suggestion) {
                                              States? p = suggestion as States;
                                              return ListTile(
                                                  leading:
                                                      Icon(Icons.location_on),
                                                  title: Text(p.name));
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              States? p = suggestion as States;
                                              _stateNameController.text =
                                                  p.name;
                                              _states = p;
                                              _cityNameController.text = "";
                                              _city = City();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Cidade:"),
                                          TypeAheadField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                                    controller:
                                                        _cityNameController,
                                                    autofocus: false,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder())),
                                            suggestionsCallback:
                                                (pattern) async {
                                              if (_states != null) {
                                                return await _cityRepository
                                                    .list(_states!.uf, pattern,
                                                        _key);
                                              } else {
                                                return await Future.delayed(
                                                    Duration.zero, () {
                                                  return [
                                                    City(
                                                        name:
                                                            "Escolha um estado",
                                                        uf: "404")
                                                  ];
                                                });
                                              }
                                            },
                                            itemBuilder: (context, suggestion) {
                                              City? p = suggestion as City;
                                              if (p.uf != "404") {
                                                return ListTile(
                                                    leading: Icon(
                                                        Icons.location_city),
                                                    title: Text(p.name));
                                              } else {
                                                return Text(p.name);
                                              }
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              City? p = suggestion as City;
                                              if (p.uf != "404") {
                                                _cityNameController.text =
                                                    p.name;
                                                _city = p;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _seeContact = !_seeContact;
                                });
                              },
                              icon: _seeContact
                                  ? Icon(
                                      Icons.visibility,
                                      color: Color(ColorsDefault.primary),
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Color(ColorsDefault.primary),
                                    ),
                              label: Text(
                                "Contatos",
                                style: TextStyle(
                                  color: Color(ColorsDefault.primary),
                                ),
                              )),
                        ),
                        Visibility(
                            visible: _seeContact,
                            child: Column(
                              children: [
                                Wrap(
                                  children: [
                                    Container(
                                        child: FieldFormWithDescription(
                                            width: 300,
                                            controller: _emailController,
                                            description: "E-mail:",
                                            margin: EdgeInsets.only(
                                                right: 45, bottom: 15))),
                                    Container(
                                        child: FieldFormWithDescription(
                                            width: 250,
                                            controller: _phone1Controller,
                                            description: "Telefone principal:",
                                            margin: EdgeInsets.only(
                                                bottom: 15, right: 15))),
                                    Container(
                                        child: FieldFormWithDescription(
                                            width: 250,
                                            controller: _phone2Controller,
                                            description: "Celular:"))
                                  ],
                                )
                              ],
                            ))
                      ],
                    )),
              ),
      ),
      bottomNavigationBar: BottomMenuThreeButton(
        loaderCreate: _loaderCreate,
        functionSave: () async {
          if (_keyForm.currentState!.validate()) {
            Provider provider = _getDatas();
            setState(() {
              _loaderCreate = true;
            });
            if (_id == null)
              _create(provider);
            else
              _alter(_id, provider);
          }
        },
        functionSaveAndCreateNew: () async {
          Provider provider = _getDatas();
          setState(() {
            _loaderCreate = true;
          });
          provider = await _create(provider);

          if (provider.id != null) _cleanDatas();
        },
      ),
    );
  }

  Provider _getDatas() {
    String name = _nameController.text;
    String fantasyName = _fantasyNameController.text;
    String cpfCnpj = _cpfCnpjController.text.replaceAll(RegExp('\\D'), '');
    String street = _streetController.text;
    String district = _districtController.text;
    String zipcode = _zipCodeController.text;
    String number = _numberController.text;
    String info = _infoController.text;
    String phoneNumber1 = _phone1Controller.text;
    String phoneNumber2 = _phone2Controller.text;
    String email = _emailController.text;

    Address address = Address(
        id: _idAddr,
        street: street,
        district: district,
        zipCode: zipcode,
        number: number,
        info: info,
        state: _states,
        city: _city);

    List<Phone> phones = [];

    if (phoneNumber1.isNotEmpty) {
      Phone phone1 = Phone(id: _idPhone1, number: phoneNumber1, type: "FIXED");
      phones.add(phone1);
    }

    if (phoneNumber2.isNotEmpty) {
      Phone phone2 = Phone(id: _idPhone2, number: phoneNumber2, type: "CELL");
      phones.add(phone2);
    }

    Person person = Person(
        id: _idPers,
        name: name,
        cpfcnpj: cpfCnpj,
        address: address,
        email: email,
        phone: phones);

    Provider provider = Provider(
        id: _id, fantasyName: fantasyName, active: _active, person: person);
    return provider;
  }

  _cleanDatas() {
    _id = null;
    _idAddr = null;
    _idPers = null;
    _idPhone1 = null;
    _idPhone2 = null;
    _active = true;

    _nameController.clear();
    _fantasyNameController.clear();
    _cpfCnpjController.clear();
    _streetController.clear();
    _districtController.clear();
    _zipCodeController.clear();
    _numberController.clear();
    _infoController.clear();
    _stateNameController.clear();
    _cityNameController.clear();
    _emailController.clear();
    _phone1Controller.clear();
    _phone2Controller.clear();
  }

  bool _loaderCreate = false;
  bool _loaderPage = true;
  bool _seeAddress = false, _seeContact = false;
  var _id, _idAddr, _idPers, _idPhone1, _idPhone2;
  var _active = true;
  var _nameController = TextEditingController();
  var _fantasyNameController = TextEditingController();
  var _cpfCnpjController = MaskedTextController(mask: "000.000.000-00");
  var _streetController = TextEditingController();
  var _districtController = TextEditingController();
  var _zipCodeController = TextEditingController();
  var _numberController = TextEditingController();
  var _infoController = TextEditingController();
  var _stateNameController = TextEditingController();
  var _cityNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phone1Controller = MaskedTextController(mask: "(00) 0000-0000");
  var _phone2Controller = MaskedTextController(mask: "(00) 0000-0000");

  _alterMask() {
    _cpfCnpjController.beforeChange = (String previous, String next) {
      if (next.length > 14) {
        // change to CNPJ format
        if (_cpfCnpjController.mask != '00.000.000/0000-00')
          _cpfCnpjController.updateMask('00.000.000/0000-00');
      } else if (next.length > 1 && next.length < 14) {
        // change to CPF format
        if (_cpfCnpjController.mask != '000.000.000-00')
          _cpfCnpjController.updateMask('000.000.000-00');
      }
      return true;
    };

    _phone1Controller.beforeChange = (String previous, String next) {
      if (next.length > 14) {
        if (_phone1Controller.mask != '(00) 00000-0000')
          _phone1Controller.updateMask('(00) 00000-0000');
      } else {
        if (_phone1Controller.mask != '(00) 0000-0000')
          _phone1Controller.updateMask('(00) 0000-0000');
      }
      return true;
    };

    _phone2Controller.beforeChange = (String previous, String next) {
      if (next.length > 14) {
        if (_phone2Controller.mask != '(00) 00000-0000')
          _phone2Controller.updateMask('(00) 00000-0000');
      } else {
        if (_phone2Controller.mask != '(00) 0000-0000')
          _phone2Controller.updateMask('(00) 0000-0000');
      }
      return true;
    };
  }

  var _repository = ProviderRepository();
  var _stateRepository = StateRepository();
  var _cityRepository = CityRepository();
  var _receitaWsRepository = ReceitaWsRepository();
  var _key = GlobalKey<ScaffoldState>();
  var _keyForm = GlobalKey<FormState>();

  States? _states;
  City? _city;

  Future<Provider> _create(Provider provider) async {
    if (_loaderCreate) {
      provider = await _repository.create(provider, _key);
      _id = provider.id;
      _loadDatas(provider);
      setState(() {
        _loaderCreate = false;
      });
    }
    return Future.value(provider);
  }

  Future<Provider> _alter(int id, Provider provider) async {
    if (_loaderCreate) {
      provider = await _repository.alter(id, provider, _key);
      setState(() {
        _loaderCreate = false;
      });
    }
    return Future.value(provider);
  }

  Future _find() async {
    _id = ModalRoute.of(context)!.settings.arguments;
    if (_id != null) {
      Provider provider = await _repository.find(_id, _key);
      _loadDatas(provider);
    }
    setState(() {
      _loaderPage = false;
    });
  }

  Future _findCnpj(String cnpj) async {
    setState(() {
      _loaderPage = true;
    });

    ReceitaWs receitaWs = await _receitaWsRepository.findCfpj(cnpj, _key);
    _nameController.text = receitaWs.nome;
    _fantasyNameController.text = receitaWs.fantasia;
    _infoController.text = receitaWs.complemento;
    _phone1Controller.text = receitaWs.telefone;
    _emailController.text = receitaWs.email;
    _zipCodeController.text = receitaWs.cep;
    _districtController.text = receitaWs.bairro;
    _streetController.text = receitaWs.logradouro;
    _numberController.text = receitaWs.numero;

    String uf = receitaWs.uf;
    _states = await _stateRepository.find(uf, _key);
    _stateNameController.text = _states!.name;

    String nameCity = receitaWs.municipio;
    await _cityRepository.list(uf, nameCity, _key).then((citys) {
      _city = citys.elementAt(0);
      _cityNameController.text = _city!.name;
    });

    setState(() {
      _loaderPage = false;
    });
  }

  _loadDatas(Provider provider) {
    if (provider.person!.cpfcnpj.length == 14) {
      _cpfCnpjController.updateMask('00.000.000/0000-00');
    } else {
      _cpfCnpjController.updateMask('000.000.000-00');
    }

    _nameController.text = provider.person!.name;
    _fantasyNameController.text = provider.fantasyName;
    _cpfCnpjController.text = provider.person!.cpfcnpj;
    _active = provider.active;
    _emailController.text = provider.person!.email;

    _idPers = provider.person!.id;

    Address address = provider.person!.address!;

    _idAddr = address.id;
    _streetController.text = address.street!;
    _districtController.text = address.district!;
    _zipCodeController.text = address.zipCode!;
    _numberController.text = address.number!;
    _infoController.text = address.info!;
    _stateNameController.text =
        address.state != null ? address.state!.name : "";
    _cityNameController.text = address.city != null ? address.city!.name : "";

    if (address.state != null) _states = address.state!;

    if (address.city != null) _city = address.city!;

    //Get phones
    if (provider.person!.phone != null) {
      for (int i = 0; i < provider.person!.phone!.length; i++) {
        Phone phone = provider.person!.phone!.elementAt(i);
        if (phone.type == "FIXED") {
          _idPhone1 = phone.id;
          _phone1Controller.text = phone.number;
        } else if (phone.type == "CELL") {
          _idPhone2 = phone.id;
          _phone2Controller.text = phone.number;
        }
      }
    }
  }
}

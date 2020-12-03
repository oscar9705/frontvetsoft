import 'dart:convert';
import 'dart:math';

import 'package:demo/src/bloc/login_bloc.dart';
import 'package:demo/src/bloc/user_bloc.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/widget/background_widget.dart';
import 'package:demo/src/widget/button_blue_widget.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String texto;
  final GlobalKey<FormState> _formRegister = GlobalKey<FormState>();
  LoginBloc loginBloc;
  DateTime _date;
  String _typeDocument;
  List<String> _list = List();
  User user = User(
      id: null,
      names: '',
      surnames: '',
      documentType: '',
      documentValue: '',
      birthdate: null,
      department: '',
      city: '',
      neighborhood: '',
      telephone: '',
      email: '',
      password: '',
      state: null,
      role: '');

  String _dateLabel() {
    return _date.toString().contains('null') ? ' ' : _date.toString();
  }

  void _selection(String selectType) {
    setState(() {
      _typeDocument = selectType;
      String _type;
      if (_typeDocument == "CC") {
        _type = "CC";
        _list = ["CC", "TI", "CE"];
        user.documentType = _type;
      }
      if (_typeDocument == "TI") {
        _type = "TI";
        _list = ["TI", "CC", "CE"];
        user.documentType = _type;
      }
      if (_typeDocument == "CE") {
        _type = "CE";
        _list = ["CE", "TI", "CC"];
        user.documentType = _type;
      }
      _typeDocument = _type;
    });
  }

  @override
  void initState() {
    super.initState();
    lista();
    loginBloc = LoginBloc();
  }

  List<String> lista() {
    _list = ["CC", "TI", "CE"];
    return _list;
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Volver',
                style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) =>
                  value.isEmpty ? Constants.requireData : null,
              onSaved: (value) {
                setUser(value, title);
              },
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  void setUser(String value, String title) {
    if (title == "Nombres") user.names = value;
    if (title == "Apellidos") user.surnames = value;
    if (title == "Documento") user.documentValue = value;
    if (title == "Ciudad") user.city = value;
    if (title == "Barrio") user.neighborhood = value;
    if (title == "Telefono") user.telephone = value;
    if (title == "Correo") user.email = value;
    if (title == "Contraseña") user.password = value;
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2021),
      locale: const Locale("es", "ES"),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        print("prueba");
        print(_date.toString());
        user.birthdate = picked;
      });
    }
  }

  Widget _registryBody() {
    return Form(
      key: _formRegister,
      child: Column(
        children: <Widget>[
          _entryField("Nombres"),
          _entryField("Apellidos"),
          _entryField("Documuento"),
          SizedBox(
            height: 20.0,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text('Tipo de documento',
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    SizedBox(
                      width: 15.0,
                    ),
                    DropdownButton<String>(
                      value: _list[0],
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black87),
                      underline: Container(
                        height: 2,
                        color: Colors.blueGrey[700],
                      ),
                      onChanged: (value) {
                        _typeDocument = value;
                      },
                      items:
                          _list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            _selection(value);
                          },
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ]),
          SizedBox(
            height: 20.0,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text('Fecha nacimiento',
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          selectDate(context);
                        },
                      ),
                    ),
                    Text(_dateLabel()),
                  ],
                ),
              ]),
          SizedBox(
            height: 20.0,
          ),
          _entryField("Departamento"),
          _entryField("Ciudad"),
          _entryField("Barrio"),
          _entryField("Telefono"),
          _entryField("Correo"),
          _entryField("Contraseña", isPassword: true),
        ],
      ),
    );
  }

  void submit() {
    final formRegister = _formRegister.currentState;
    formRegister.save();
    user.state = false;
    user.role = "AUX";
    print(user.birthdate.toString());
    loginBloc.register(user).then((ApiResponse resp) {
      if (resp.statusResponse == 200) {
        print(resp.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            BackgroundWidget(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    TitleApp(),
                    SizedBox(
                      height: 50,
                    ),
                    _registryBody(),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonBlue(
                      onTap: submit,
                      texto: 'Iniciar sesión',
                    ),
                    SizedBox(height: height * .14)
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
  }
}

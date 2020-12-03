import 'dart:math';

import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DateTime _date;
  String _typeDocument;
  List<String> _list = List();

  void _selection(String selectType) {
    setState(() {
      _typeDocument = selectType;
      String _type;
      if (_typeDocument == "CC") {
        _type = "CC";
        _list = ["CC", "TI", "CE"];
      }
      if (_typeDocument == "TI") {
        _type = "TI";
        _list = ["TI", "CC", "CE"];
        print(_list);
      }
      if (_typeDocument == "CE") {
        _type = "CE";
        _list = ["CE", "TI", "CC"];
      }
      _typeDocument = _type;
    });
  }

  @override
  void initState() {
    super.initState();
    lista();
  }

  List<String> lista() {
    _list = ["CC", "TI", "CE"];
    print(_list.toString());
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
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.white30,
                offset: Offset(2, 4),
                blurRadius: 10,
                spreadRadius: 1)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue[600], Colors.blueAccent[100]])),
      child: Text(
        'Registrar',
        style: GoogleFonts.portLligatSlab(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    );
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
        print(_date);
      });
    }
  }

  String _dateLabel() {
    return _date.toString().contains('null') ? ' ' : _date.toString();
  }

  Widget _registryBody() {
    return Column(
      children: <Widget>[
        _entryField("Nombres"),
        _entryField("Apellidos"),
        _entryField("Documuento"),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
                  print(_typeDocument);
                },
                items: _list.map<DropdownMenuItem<String>>((String value) {
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
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
        _entryField("Departamento"),
        _entryField("Ciudad"),
        _entryField("Barrio"),
        _entryField("Telefono"),
        _entryField("Correo"),
        _entryField("Contraseña", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: Container(
                    child: Transform.rotate(
                  angle: -pi / 3.5,
                  child: ClipPath(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width * 2.3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.blueGrey[100],
                            Colors.lightBlue[50]
                          ])),
                    ),
                  ),
                ))),
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
                    _submitButton(),
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
}

import 'dart:ui';

import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/widget/title_widget.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulo(),
                _botonesRedondeados(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _titulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30.0),
            TitleApp(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Colors.blueGrey[200],
            Colors.lightBlue[100],
          ],
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(1, 87, 155, 0.7),
            primaryColor: Color.fromRGBO(83, 221, 205, 0.8),
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Color.fromRGBO(207, 216, 220, 1.0)))),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 30.0,
              ),
              label: "Perfil",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bubble_chart,
                size: 30.0,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,
                size: 30.0,
              ),
              label: "Salir",
            ),
          ],
        ));
  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Constants.colorPrimary,
              Icons.store_mall_directory_outlined, 'Veterinarias'),
          _crearBotonRedondeado(Constants.colorPrimary,
              Icons.store_mall_directory_outlined, 'Sucursales'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Constants.colorPrimary,
              Icons.people_alt_rounded,
              'Usuarios',
              () => Navigator.pushNamed(context, 'users')),
          _crearBotonRedondeado(Constants.colorPrimary, Icons.pets_sharp,
              'Mascotas', () => Navigator.pushNamed(context, 'pets')),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Constants.colorPrimary, Icons.people_alt_rounded, 'citas'),
          _crearBotonRedondeado(
              Constants.colorPrimary, Icons.pets_sharp, 'Historias'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Constants.colorPrimary, Icons.people_alt_rounded, 'Veterinarios'),
          _crearBotonRedondeado(
              Constants.colorPrimary, Icons.pets_sharp, 'Auxiliares'),
        ]),
      ],
    );
  }

  void usersRoute() {
    Navigator.pushNamed(context, 'users');
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto,
      [VoidCallback tap]) {
    return ClipRect(
      child: InkWell(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            height: 250.0,
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(1, 87, 155, 0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(
                    icono,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                Text(texto, style: TextStyle(color: color)),
                SizedBox(height: 5.0),
              ],
            ),
          ),
        ),
        onTap: tap,
      ),
    );
  }
}

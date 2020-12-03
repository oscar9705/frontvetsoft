import 'dart:math';

import 'package:flutter/material.dart';

class PetPawBackgroundWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
      child: ClipPath(
        clipper: MyCustomClipper(),
        child: Container(
          height: 500,
          width: 400,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlue[50], Colors.blueGrey[50]])),
        ),
      ),
    ));
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addOval(
          Rect.fromLTWH(0, size.height - 200, 120, 100).translate(120, 80))
      ..addOval(Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2), radius: 30)
          .translate(100, 130))
      ..addOval(Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2), radius: 32)
          .translate(40, 90))
      ..addOval(Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2), radius: 32)
          .translate(-40, 90))
      ..addOval(Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2), radius: 30)
          .translate(-100, 130))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                      colors: [Colors.blueGrey[100], Colors.lightBlue[50]])),
            ),
          ),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonBlue extends StatelessWidget {
  final VoidCallback onTap;
  final String texto;
  const ButtonBlue({Key key, this.onTap, this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
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
          texto,
          style: GoogleFonts.portLligatSlab(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}

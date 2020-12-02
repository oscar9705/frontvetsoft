import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Pet',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        TextSpan(
          text: 'Soft',
          style: GoogleFonts.portLligatSlab(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.lightBlue[900],
          ),
        ),
      ]),
    );
  }
}

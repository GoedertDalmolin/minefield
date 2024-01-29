import 'package:flutter/material.dart';
import 'package:minefield/components/resultado_widget.dart';

class CampoMinadoApp extends StatelessWidget {
  const CampoMinadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu:  true,
          onReiniciar: () {},
        ),
        body: Container(
          child: Text('Tabuleiro'),
        ),
      ),
    );
  }
}

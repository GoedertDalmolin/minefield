import 'package:flutter/material.dart';
import 'package:minefield/components/campo_widget.dart';
import 'package:minefield/models/campo.dart';
import 'package:minefield/models/tabuleiro.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final Function(Campo) onAbrir;
  final Function(Campo) onAlternarMarcacao;

  const TabuleiroWidget({
    required this.tabuleiro,
    super.key,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos.map((c) {
          return CampoWidget(
            campo: c,
            onAbrir: onAbrir,
            onAlternarMarcacao: onAlternarMarcacao,
          );
        }).toList(),
      ),
    );
  }
}

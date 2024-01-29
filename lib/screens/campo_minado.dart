import 'package:flutter/material.dart';
import 'package:minefield/components/resultado_widget.dart';
import 'package:minefield/components/tabuleiro_widget.dart';
import 'package:minefield/models/campo.dart';
import 'package:minefield/models/explosao_exception.dart';
import 'package:minefield/models/tabuleiro.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({super.key});

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? tabuleiro;

  _reiniciar() {
    setState(() {
      _venceu = null;
      tabuleiro!.reiniciar();
    });
  }

  _alternarMarcacao(Campo campo) {
    debugPrint('Alterar Marcação');
    setState(() {
      if (_venceu != null) return;

      campo.alternarMarcacao();
      if (tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  _abrir(Campo campo) {
    debugPrint('Abrir Campo');
    setState(() {
      if (_venceu != null) return;

      try {
        campo.abrir();
        if (tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        tabuleiro!.revelarBombas();
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (tabuleiro == null) {
      int qtdeColunas = 10;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      tabuleiro = Tabuleiro(linhas: qtdeLinhas, colunas: qtdeColunas, qtdeBombas: 20);
    }

    return tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (ctx, contraints) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(contraints.maxWidth, contraints.maxHeight),
                onAbrir: _abrir,
                onAlternarMarcacao: _alternarMarcacao,
              );
            },
          ),
        ),
      ),
    );
  }
}

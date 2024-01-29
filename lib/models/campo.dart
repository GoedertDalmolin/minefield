import 'explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    required this.linha,
    required this.coluna,
  });

  adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  abrir() {
    if (_aberto) {
      return;
    }

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      for (var v in vizinhos) {
        v.abrir();
      }
    }
  }

  revelarBombas() {
    if (_minado) {
      _aberto = true;
    }
  }

  minar() {
    _minado = true;
  }

  alternarMarcacao() {
    _marcado = !_marcado;
  }

  reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get resolvido {
    bool minadoEMarcado = _minado && marcado;
    bool seguroEAberto = !minado && aberto;

    return minadoEMarcado || seguroEAberto;
  }

  bool get vizinhancaSegura {
    return vizinhos.every((v) => !v.minado);
  }

  int get qtdeMinasNaVizinhanca {
    return vizinhos.where((element) => element.minado).length;
  }
}

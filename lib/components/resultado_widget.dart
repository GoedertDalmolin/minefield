import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final Function() onReiniciar;

  @override
  Size get preferredSize => const Size.fromHeight(120);

  const ResultadoWidget({
    required this.venceu,
    required this.onReiniciar,
  });

  Color _getColor() {
    if (venceu == null) {
      return Colors.yellow;
    } else if (venceu == true) {
      return Colors.green[300]!;
    } else {
      return Colors.red[300]!;
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu == true) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReiniciar,
            ),
          ),
        ),
      ),
    );
  }
}

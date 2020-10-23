import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:flutter/material.dart';

class BotonAtomo extends StatelessWidget {
  BotonAtomo(
      {Key key,
      @required this.color,
      @required this.texto,
      this.estiloTexto,
      @required this.colorBorde,
      @required this.funcion})
      : super(key: key);

  final Color color;
  final String texto;
  final TextStyle estiloTexto;
  final Color colorBorde;
  final VoidCallback funcion;

  Widget build(BuildContext context) {
    return RaisedButton(
        color: this.color,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            this.texto,
            style: estiloTexto != null
                ? this.estiloTexto
                : Estilos.estiloBoldAzul12,
            textAlign: TextAlign.center,
          ),
        ),
        disabledColor: Estilos.colorBotonDeshabilitado,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: this.colorBorde, width: 2.0)),
        onPressed: () {
          this.funcion();
        });
  }
}

import 'package:flutter/material.dart';

class Tarjeta extends StatelessWidget {
  Tarjeta({Key key,
        @required this.nombre,
        @required this.direccion,
        @required this.detalle,
        @required this.foto,
        @required this.calificacion}) 
        : super(key: key);

  final String nombre;
  final String direccion;
  final String detalle;
  final String foto;
  final double calificacion;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [

        ],
      ),
    );
  }
}



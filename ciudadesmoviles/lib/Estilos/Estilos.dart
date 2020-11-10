import 'package:flutter/material.dart';

class Estilos {
  static const Color colorPrincipal = Colors.redAccent;
  static const Color colorMapa = Color(0x1A2196F3);
  static const Color colorMenu = Colors.lightBlue;

  //Estilos tarjetas
  static const Color disponible = Color(0xFF2ecc71);
  static const Color moderado = Color(0xFFe67e22);
  static const Color nodisponible = Color(0xFFc0392b);

  //Estilos de los botones
  static const TextStyle estiloTextoBoton =
      TextStyle(color: Colors.white, fontSize: 15);
  static const Color estiloBoldAzul12 = Colors.blueAccent;
  static const Color colorBotonDeshabilitado = Colors.grey;
  static const Color bordeBoton = Colors.blue;
  static const Color colorazul = Colors.blue;

  //Estilos de los textos
  static const TextStyle estiloTextoCelular = TextStyle(fontSize: 18);
  static const TextStyle estiloNormalAzul14 = TextStyle(
      fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.normal);
  static const TextStyle estiloBoldBlanco18 =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle estiloNormalBlanco14 =
      TextStyle(fontSize: 14, color: Colors.white);
}

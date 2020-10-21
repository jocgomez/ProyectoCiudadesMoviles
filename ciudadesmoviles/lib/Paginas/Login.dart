import 'package:flutter/material.dart';

class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //PUSE ESTE BOTON COMO EJEMPLO PARA EMPEZAR EN EL LOGIN QUE VAS A DESARROLLAR
      //Y LUEGO PASAR A LA RUTA HOME QUE AUN NO ESTA DESARROLLADA, PARA PODER TRABAJAR PUSE MAPA
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, '/mapa');
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:flutter/material.dart';

class Tarjetas extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _TarjetasState();
  
  }//Fin método

}//Fin clase

class _TarjetasState extends State{

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Interfaz tarjetas")),

    );
  }

}
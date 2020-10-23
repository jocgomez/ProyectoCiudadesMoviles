import 'package:flutter/material.dart';

class InicioCelular extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _InicioCelularState();
  
  }//Fin método

}//Fin clase

class _InicioCelularState extends State{

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(

        title: Text('Inicio sesión con celular'),

      ),

    );

  }//Fin Widget

}//Fin clase
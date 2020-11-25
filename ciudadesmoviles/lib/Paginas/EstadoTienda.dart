import 'package:flutter/material.dart';
import 'package:ciudadesmoviles/Modelos/Tienda.dart';


class EstadoTienda extends StatefulWidget{

  final List<Tienda> tiendasEstados;
  final String cadena;
  
  EstadoTienda(this.tiendasEstados, this.cadena);

  @override
  State<StatefulWidget> createState() {
    return _EstadoTiendaState();
  } //Fin método

}

class _EstadoTiendaState extends State<EstadoTienda>{

  List<Tienda> establecimientos;
  String estadoT;

  @override
  void initState() { 

    establecimientos =  this.widget.tiendasEstados;
    estadoT = this.widget.cadena;

    imprimir();

    super.initState();
    
  }

   @override
  Widget build(BuildContext context) {
 
    return Scaffold(

      appBar: AppBar(

        title: Text("Estado tiendas"),

      ),

    );
 
  }

  void imprimir(){

    print(establecimientos);
    print(estadoT);

  }

}//Fin método
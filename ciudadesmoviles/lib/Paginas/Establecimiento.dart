import 'dart:convert';

import 'package:ciudadesmoviles/Componentes/boton.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:flutter/material.dart';

class Establecimientos extends StatefulWidget {
  _EstablecimientoState createState() => _EstablecimientoState();
}

class _EstablecimientoState extends State<Establecimientos> {
  String nombreE;
  String direccionE;
  String nitE;
  String fotoE;
  int capacidadE;
  int calificacionE;
  int longitudE;
  int latitudE;
  int ocupadoE = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar establecimiento"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, hintText: "Nombre"),
                    onChanged: (valor) {
                      nombreE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, hintText: "Dirección"),
                    onChanged: (valor) {
                      direccionE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true, hintText: "NIT establecimiento"),
                    onChanged: (valor) {
                      nitE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(filled: true, hintText: "Foto"),
                    onChanged: (valor) {
                      fotoE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true, hintText: "Máxima capacidad"),
                    onChanged: (valor) {
                      capacidadE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(filled: true, hintText: "Calificación"),
                    onChanged: (valor) {
                      calificacionE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(filled: true, hintText: "Longitud"),
                    onChanged: (valor) {
                      longitudE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(filled: true, hintText: "Latitud"),
                    onChanged: (valor) {
                      latitudE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: BotonAtomo(
                      color: Estilos.colorazul,
                      estiloTexto: Estilos.estiloTextoBoton,
                      texto: "Guardar establecimiento",
                      colorBorde: Estilos.bordeBoton,
                      funcion: () {
                        _guardarDatos();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } //Fin Widget

  void _guardarDatos() async {
    var json = {};

    json['nombre'] = nombreE;
    json['direccion'] = direccionE;
    json['nit'] = nitE;
    json['foto'] = fotoE;
    json['capacidad'] = capacidadE;
    json['calificacion'] = calificacionE;
    json['longitud'] = longitudE;
    json['latitud'] = latitudE;
    json['ocupado'] = ocupadoE;

    String establecimiento = jsonEncode(json);

    final response = await Tienda().guardarEstablecimiento(establecimiento);

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Confirmación guardado"),
                content: Text(
                    "Los datos del establecimiento se guardaron adecuadamente."),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Aceptar"))
                ],
              ));
    } //Fin condición if
  } //Fin método

}

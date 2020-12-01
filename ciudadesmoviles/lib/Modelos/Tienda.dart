import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Tienda {
  final String nit;
  final String nombre;
  final int capacidad;
  final double calificacion;
  final String direccion;
  final LatLng position;
  final String foto;
  final int ocupado;
  static List<Tienda> tiendas = new List<Tienda>();

  Tienda(
      {this.nit,
      this.nombre,
      this.capacidad,
      this.calificacion,
      this.direccion,
      this.position,
      this.foto,
      this.ocupado});

  Future traerTiendas() async {
    //CAMBIAR URL AL INICIAR EL SERVIDOR
    final response =
        await http.get('http://10.0.2.2:3000/TraerEstablecimientos');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final tiendasBD = jsonDecode(response.body);
      Tienda.tiendas = List();
      tiendasBD.forEach((tiendaBD) {
        Tienda tienda = new Tienda(
            nit: tiendaBD['nit'],
            nombre: tiendaBD['nombre'],
            calificacion: double.tryParse(tiendaBD['calificacion'].toString()),
            capacidad: tiendaBD['capacidad'],
            ocupado: tiendaBD['ocupado'],
            direccion: tiendaBD['direccion'],
            foto: tiendaBD['foto'],
            position: LatLng(tiendaBD["latitud"], tiendaBD["longitud"]));
        Tienda.tiendas.add(tienda);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw new Exception("Error while fetching data");
    }
  }

  Future<List> traerTemperaturasExcedidas() async {
    //CAMBIAR URL AL INICIAR EL SERVIDOR
    final response = await http
        .get('http://10.0.2.2:3000/traer-establecimientos/temperatura');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final temperaturas = jsonDecode(response.body);
      List tempTiendas = List();
      temperaturas.forEach((tempsBD) {
        var tienda = {
          "id": tempsBD['id'],
          "data": tempsBD['data'],
        };
        tempTiendas.add(tienda);
      });
      return tempTiendas;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw new Exception("Error while fetching data");
    }
  }

  Future<http.Response> guardarEstablecimiento(String datos) async {
    return await http.post('http://10.0.2.2:3000/datosEnviar',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: datos);
  } //Fin método

}

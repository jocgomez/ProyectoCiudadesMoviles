import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tienda {
  final String nit;
  final String nombre;
  final int capacidad;
  final double calificacion;
  final String direccion;
  final LatLng position;
  final String foto;
  final int ocupado;

  Tienda(
      {this.nit,
      this.nombre,
      this.capacidad,
      this.calificacion,
      this.direccion,
      this.position,
      this.foto,
      this.ocupado});
}

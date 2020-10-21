import 'dart:async';

import 'dart:math' as math;
import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapaPagina extends StatefulWidget {
  @override
  _MapaPaginaState createState() => _MapaPaginaState();
}

class _MapaPaginaState extends State<MapaPagina> {
  List<Tienda> tiendas = List();

  Location _location = Location();
  StreamSubscription<LocationData> subscription;
  GoogleMapController _mapController;
  String _placemark;
  String newLocationName;
  BitmapDescriptor myIcon;
  ScrollController listController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    permisoUbicacion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  permisoUbicacion() async {
    // SOLICITA PERMISOS PARA MANEJAR MAPS
    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    /* var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        print("No permission");
        return;
      }
    }

    _buscarTiendas();

    // EMPIEZA A ESCUCHAR LOS CAMBIOS DE POSICIÓN LATITUD LONGITUD
    subscription = _location.onLocationChanged().listen((LocationData event) {
      if (_mapController != null) {
        double minX = personas.map((e) => e.position.latitude).reduce(math.min);
        double maxX = personas.map((e) => e.position.latitude).reduce(math.max);
        double minY =
            personas.map((e) => e.position.longitude).reduce(math.min);
        double maxY =
            personas.map((e) => e.position.longitude).reduce(math.max);

        minX = math.min(minX, event.latitude);
        maxX = math.max(maxX, event.latitude);
        minY = math.min(minY, event.longitude);
        maxY = math.max(maxY, event.longitude);

        //LatLngBounds bounds = LatLngBounds(
        //southwest: LatLng(minX, minY), northeast: LatLng(maxX, maxY));

        //_mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
        _mapController.animateCamera(
            CameraUpdate.newLatLng(LatLng(event.latitude, event.longitude)));
      }

      // IMPRIME EN CONSOLA LOS CAMBIOS DE POSICIÓN

      obtenerDireccion(event.latitude, event.longitude);

      latitud = event.latitude;
      longitud = event.longitude;

      Common.latitud = event.latitude;
      Common.longitud = event.longitude;

      print("${event.latitude},${event.longitude}");
    }); */
  }

  void _buscarTiendas() {}
}

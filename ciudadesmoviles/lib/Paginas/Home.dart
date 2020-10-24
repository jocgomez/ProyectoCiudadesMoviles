import 'dart:async';

import 'package:ciudadesmoviles/Modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePagina extends StatefulWidget {
  @override
  _HomePaginaState createState() => _HomePaginaState();
}

class _HomePaginaState extends State<HomePagina> {
  Location _location = Location();
  StreamSubscription<LocationData> subscription;

  @override
  void initState() {
    _initLocation();
    super.initState();
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CapacidApp"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "/mapa");
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Metodo para solicitar permiso de ubicación y actualizar mi ubicación actual
  _initLocation() async {
    // SOLICITA PERMISOS PARA MANEJAR MAPS
    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    subscription = _location.onLocationChanged().listen((LocationData event) {
      Usuario.latitud = event.latitude;
      Usuario.longitud = event.longitude;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  Location _location = Location();

  @override
  void initState() {
    // TODO: implement initState
    _initLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //PUSE ESTE BOTON COMO EJEMPLO PARA EMPEZAR EN EL LOGIN QUE VAS A DESARROLLAR
      //Y LUEGO PASAR A LA RUTA HOME QUE AUN NO ESTA DESARROLLADA, PARA PODER TRABAJAR PUSE MAPA
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/mapa');
        },
        child: Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

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
        print("No permission");
        return;
      }
    }
  }
}

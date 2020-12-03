import 'dart:async';
import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:ciudadesmoviles/Modelos/Usuario.dart';
import 'package:ciudadesmoviles/Paginas/Menu_Lateral.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:ciudadesmoviles/Componentes/Tarjeta.dart';

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
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("CapacidApp"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Tienda().traerTiendas().then((value) {
            setState(() {});
          });
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: Tienda.tiendas.length,
            itemBuilder: (context, index) {
              var tienda = Tienda.tiendas[index];
              var disponibilidad = ((tienda.ocupado / tienda.capacidad) * 100);
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Tarjeta(
                      nombre: tienda.nombre,
                      direccion: tienda.direccion,
                      calificacion: tienda.calificacion,
                      foto: '${tienda.foto}',
                      capacidad:
                          'Capacidad ${tienda.ocupado}/${tienda.capacidad}',
                      colorCapacidad: disponibilidad <= 70
                          ? Estilos.disponible
                          : disponibilidad > 70 && disponibilidad < 100
                              ? Estilos.moderado
                              : Estilos.nodisponible,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
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

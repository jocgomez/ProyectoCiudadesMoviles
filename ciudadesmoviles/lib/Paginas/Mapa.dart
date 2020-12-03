import 'dart:async';

import 'dart:math' as math;
import 'dart:math' show cos, sqrt, asin;
import 'package:ciudadesmoviles/Componentes/Tarjeta.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:ciudadesmoviles/Modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class MapaPagina extends StatefulWidget {
  @override
  _MapaPaginaState createState() => _MapaPaginaState();
}

class _MapaPaginaState extends State<MapaPagina> {
  Location _location = Location();
  StreamSubscription<LocationData> subscription;
  GoogleMapController _mapController;
  String _placemark;
  String newLocationName;
  BitmapDescriptor myIcon;
  ScrollController listController = new ScrollController();

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;

  Position currentLocation;
  Position _position;

  double latitud = 0.0;
  double longitud = 0.0;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(32, 32)), 'assets/img/iconos/pin.png')
        .then((onValue) {
      setState(() {
        myIcon = onValue;
      });
    });

    permisoUbicacion();
    Tienda().traerTiendas().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    listController.dispose();

    if (subscription != null) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      body: Usuario.latitud == null || Usuario.longitud == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                    circles: circuloMapa,
                    markers: //Set.of(markersX.values),//
                        Tienda.tiendas
                            .map((e) => Marker(
                                  onTap: () {
                                    listController.animateTo(
                                        Tienda.tiendas.indexWhere((element) =>
                                                element.nit == e.nit) *
                                            350.0,
                                        duration: Duration(milliseconds: 1000),
                                        curve: Curves.fastOutSlowIn);
                                  },
                                  markerId: MarkerId(e.nit),
                                  position: e.position,
                                  infoWindow: InfoWindow(
                                      title: e.nombre,
                                      snippet: e.direccion,
                                      onTap: () {
                                        //abrirDetalles(e.uid);
                                      }),
                                  icon: myIcon,
                                ))
                            .toSet(),
                    onMapCreated: (controller) => _mapController = controller,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    compassEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(Usuario.latitud, Usuario.longitud),
                      zoom: 12.5,
                    ),
                    onCameraMove: (CameraPosition position) {
                      if (_markers.length > 0) {
                        MarkerId markerId = MarkerId(_markerIdVal());
                        Marker marker = _markers[markerId];
                        Marker updatedMarker = marker?.copyWith(
                          positionParam: position?.target,
                        );
                        setState(() {
                          _markers[markerId] = updatedMarker;
                          _position = position as Position;
                        });
                      }
                    },
                    onCameraIdle: () {
                      obtenerDireccion(
                          currentLocation?.latitude, currentLocation?.latitude);
                    }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 160,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            controller: listController,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 8.0),
                            itemCount: Tienda.tiendas.length,
                            itemBuilder: (context, index) {
                              var tienda = Tienda.tiendas[index];
                              var disponibilidad =
                                  ((tienda.ocupado / tienda.capacidad) * 100);

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
                                          : disponibilidad > 70 &&
                                                  disponibilidad < 100
                                              ? Estilos.moderado
                                              : Estilos.nodisponible,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  Set<Circle> circuloMapa = Set.from([
    Circle(
      circleId: CircleId("1"),
      center: LatLng(Usuario.latitud, Usuario.longitud),
      radius: 5000,
      fillColor: Estilos.colorMapa,
      strokeWidth: 0,
    )
  ]);

  permisoUbicacion() async {
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

    /* _buscarTiendas(); */

    // EMPIEZA A ESCUCHAR LOS CAMBIOS DE POSICIÓN LATITUD LONGITUD
    subscription = _location.onLocationChanged().listen((LocationData event) {
      if (_mapController != null) {
        double minX =
            Tienda.tiendas.map((e) => e.position.latitude).reduce(math.min);
        double maxX =
            Tienda.tiendas.map((e) => e.position.latitude).reduce(math.max);
        double minY =
            Tienda.tiendas.map((e) => e.position.longitude).reduce(math.min);
        double maxY =
            Tienda.tiendas.map((e) => e.position.longitude).reduce(math.max);

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

      Usuario.latitud = event.latitude;
      Usuario.longitud = event.longitude;

      setState(() {});
    });
  }

  /* void _buscarTiendas() async {
    await Firestore.instance.collection('Tiendas').snapshots().listen((event) {
      event.documents.forEach((element) {
        if (element['nombre'] != null &&
            element['latitud'] != null &&
            element['longitud'] != null &&
            element['foto'] != null &&
            element['nit'] != null &&
            element['direccion'] != null &&
            element['capacidad'] != null &&
            element['calificacion'] != null &&
            element['foto'] != null) {
          double distancia =
              calcularDistancia(element['latitud'], element['longitud']);
          if (distancia <= 5) {
            Tienda tienda = new Tienda(
                nit: element['nit'],
                nombre: element['nombre'],
                calificacion: element['calificacion'],
                capacidad: element['capacidad'],
                ocupado: element['ocupado'],
                direccion: element['direccion'],
                foto: element['foto'],
                position: LatLng(element["latitud"], element["longitud"]));
            tiendas.add(tienda);
          }
        }
      });
      setState(() {});
    });
  } */

  void obtenerDireccion(double lat, double lng) async {
    if (lat != null && lng != null) {
      List<Placemark> placemarks =
          await Geolocator()?.placemarkFromCoordinates(lat, lng);
      if (placemarks != null && placemarks.isNotEmpty) {
        final Placemark pos = placemarks[0];
        _placemark = pos.thoroughfare + ', ' + pos.name;
        newLocationName = _placemark;
        /* Common.direccion = newLocationName; */
      }
    }
  }

  double calcularDistancia(double latitud, double longitud) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((Usuario.latitud - latitud) * p) / 2 +
        c(latitud * p) *
            c(Usuario.latitud * p) *
            (1 - c((longitud - Usuario.longitud) * p)) /
            2;

    double valorDistancia = 12742 * asin(sqrt(a));

    return valorDistancia;
  }
}

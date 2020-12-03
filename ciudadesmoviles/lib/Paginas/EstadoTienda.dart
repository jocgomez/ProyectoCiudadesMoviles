import 'package:ciudadesmoviles/Componentes/Tarjeta.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:flutter/material.dart';
import 'package:ciudadesmoviles/Modelos/Tienda.dart';

class EstadoTienda extends StatefulWidget {
  final List<Tienda> tiendasEstados;
  final String estado;

  EstadoTienda(this.tiendasEstados, this.estado);

  @override
  State<StatefulWidget> createState() {
    return _EstadoTiendaState();
  } //Fin método

}

class _EstadoTiendaState extends State<EstadoTienda> {
  List<Tienda> establecimientos;
  String estadoT;

  @override
  void initState() {
    establecimientos = this.widget.tiendasEstados;
    estadoT = this.widget.estado;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(estadoT),
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
              image: AssetImage('assets/img/bgGob.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: establecimientos.length,
            itemBuilder: (context, index) {
              var tienda = establecimientos[index];
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
                      colorCapacidad: estadoT == "Disponibles"
                          ? Estilos.disponible
                          : estadoT == "Moderados"
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
} //Fin método

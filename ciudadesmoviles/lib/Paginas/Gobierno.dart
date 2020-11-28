import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:ciudadesmoviles/Paginas/EstadoTienda.dart';
import 'package:flutter/material.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:intl/intl.dart';

class EnteGobiero extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnteGobierno();
  } //Fin método

}

class _EnteGobierno extends State {
  int disponibles = 0;
  int moderados = 0;
  int noDisponibles = 0;

  //Listas que contendrá las tiendes disponibles, moderadas y no disponibles
  static List<Tienda> tiendasdisponibles;
  static List<Tienda> tiendasmoderadas;
  static List<Tienda> tiendasnoDisponibles;

  List tempTraidas;
  List tempExcedidasDias;

  //Método que se ejecuta cuando se renderiza la interfaz
  @override
  void initState() {
    super.initState();

    tiendasdisponibles = new List<Tienda>();
    tiendasmoderadas = new List<Tienda>();
    tiendasnoDisponibles = new List<Tienda>();

    cantidadEstablecimientos();
    Tienda().traerTiendas();
    Tienda().traerTemperaturasExcedidas().then((value) {
      contarTempExcedidasPorDia(value);
    });
  } //Fin método

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CapacidApp"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: 340,
                  height: 25,
                  child: Text("Estado de los establecimientos",
                      style: Estilos.estiloTextoTitulo),
                ),
                SizedBox(height: 15),
                Container(
                  width: 340,
                  height: 40,
                  child: Text(
                      "Para mayor información selecciona una de las siguiente opciones.",
                      style: Estilos.estiloTextoParrafo,
                      textAlign: TextAlign.justify),
                ),
                SizedBox(height: 30),
                Container(
                  width: 340,
                  height: 70,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: FloatingActionButton(
                            child: Text(disponibles.toString(),
                                style: Estilos.estiloTextoboton),
                            onPressed: () {
                              interfazDisponible();
                            },
                            backgroundColor: Colors.green,
                            heroTag: null,
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          child: FloatingActionButton(
                            child: Text(moderados.toString(),
                                style: Estilos.estiloTextoboton),
                            onPressed: () {
                              interfazModerada();
                            },
                            backgroundColor: Colors.yellow,
                            heroTag: null,
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          child: FloatingActionButton(
                            child: Text(noDisponibles.toString(),
                                style: Estilos.estiloTextoboton),
                            onPressed: () {
                              interfaznoDisponible();
                            },
                            backgroundColor: Colors.red,
                            heroTag: null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  width: 340,
                  height: 30,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text("Disponibles",
                              style: Estilos.estiloTextoEstado),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text("Moderados",
                              style: Estilos.estiloTextoEstado),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text("No disponibles",
                              style: Estilos.estiloTextoEstado),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: 340,
                  height: 25,
                  child: Text("Temperaturas excedidas",
                      style: Estilos.estiloTextoTitulo),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void cantidadEstablecimientos() {
    int tamanoDatos = Tienda.tiendas.length;
    var tienda = Tienda.tiendas;

    for (var i = 0; i < tamanoDatos; i++) {
      var disponibilidad = ((tienda[i].ocupado / tienda[i].capacidad) * 100);

      //Disponibles aquellos que la disponibilidad llega hasta el 70%
      if (disponibilidad <= 70) {
        disponibles++;
        tiendasdisponibles.add(tienda[i]);
      } else if (disponibilidad > 70 && disponibilidad < 100) {
        //Moderados aquellos que tienen disponibilidad entre 70 y 99%
        moderados++;
        tiendasmoderadas.add(tienda[i]);
      } else if (disponibilidad == 100) {
        //No disponibls aquellos que tienene una disponibilidad dek 100%, se encuentran ocupados
        noDisponibles++;
        tiendasnoDisponibles.add(tienda[i]);
      } //Fin condición

    } //Fin for
  } //Fin método

  void interfazDisponible() {
    if (disponibles != 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EstadoTienda(tiendasdisponibles, "Disponibles")));
    }
  } //Fin método

  void interfazModerada() {
    if (moderados != 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EstadoTienda(tiendasmoderadas, "Moderados")));
    }
  } //Fin método

  void interfaznoDisponible() {
    if (noDisponibles != 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              EstadoTienda(tiendasnoDisponibles, "No disponibles")));
    }
  }

  void contarTempExcedidasPorDia(List listaTemps) {
    try {
      DateTime today = DateTime.now();
      //Se recorre la lista de tiendas obtenidas
      listaTemps.forEach((tempTiendas) {
        //De las tiendas se obtiene todos los datos de la temp
        tempTiendas["data"].forEach((data) {
          var a =
              DateFormat('EEE MMM dd HH:mm:ss zzzz yyyy').parse(data["fecha"]);
          print(a);
        });
      });
    } catch (e) {
      print(e);
    }
  } //Fin método

} //Fin clase

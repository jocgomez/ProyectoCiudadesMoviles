import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:ciudadesmoviles/Paginas/EstadoTienda.dart';
import 'package:flutter/material.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
  Map tempExcedidasDias;

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
      setState(() {
        tempExcedidasDias = contarTempExcedidasPorDia(value);
      });
    });
  } //Fin método

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CapacidApp"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Tienda().traerTiendas();
          Tienda().traerTemperaturasExcedidas().then((value) {
            setState(() {
              tempExcedidasDias = contarTempExcedidasPorDia(value);
            });
          });
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                  ),
                  SizedBox(height: 15),
                  tempExcedidasDias != null
                      ? Container(height: 300, child: _barrasTemperaturas())
                      : CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _barrasTemperaturas() {
    DateTime now = DateTime.now();
    List<DiasExced> data = [];

    tempExcedidasDias.forEach((key, value) {
      DateTime today = new DateTime(now.year, now.month, now.day);
      DateTime otherDay = today.subtract(Duration(days: key));
      final diaSem = DateFormat('EEEE').format(otherDay);
      data.add(DiasExced(diaSem, value));
    });

    final seriesList = [
      new charts.Series<DiasExced, String>(
          id: 'Temperaturas',
          domainFn: (DiasExced temp, _) => temp.dia,
          measureFn: (DiasExced temp, _) => temp.total,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (DiasExced temp, _) => '${temp.total.toString()}')
    ];

    return new charts.BarChart(
      seriesList,
      animate: true,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
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

  Map contarTempExcedidasPorDia(List listaTemps) {
    Map tempMaxDia = new Map();
    Map diaTemp = new Map();
    for (var i = 0; i < 7; i++) {
      diaTemp[i] = 0;
      tempMaxDia[i] = 0;
    }

    try {
      DateTime now = DateTime.now();
      DateTime today = new DateTime(now.year, now.month, now.day);
      //Se recorre la lista de tiendas obtenidas
      listaTemps.forEach((tempTiendas) {
        for (var i = 0; i < 7; i++) {
          tempMaxDia[i] = 0;
        }
        //De las tiendas se obtiene todos los datos de la temp
        tempTiendas["data"].forEach((data) {
          if (data["fecha"] != null && data["fecha"] != "") {
            var fecha = data["fecha"].replaceAll(' COT ', ' ');

            DateTime fechaFormato =
                DateFormat('EEE MMM d HH:mm:ss yyyy').parse(fecha);
            DateTime fechaFinal = DateFormat('yyyy-MM-dd')
                .parse(DateFormat('yyyy-MM-dd').format(fechaFormato));

            var diferencia = today.difference(fechaFinal).inDays;

            if (diferencia >= 0 && diferencia <= 6) {
              if (data["valorT"] > tempMaxDia[diferencia]) {
                tempMaxDia[diferencia] = data["valorT"];
              }
            }
          }
        });
        for (var i = 0; i < 7; i++) {
          diaTemp[i] += tempMaxDia[i];
        }
      });
      return diaTemp;
    } catch (e) {}
  } //Fin método

} //Fin clase

class DiasExced {
  final String dia;
  final int total;

  DiasExced(this.dia, this.total);
}

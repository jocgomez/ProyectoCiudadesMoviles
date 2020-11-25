import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:ciudadesmoviles/Paginas/EstadoTienda.dart';
import 'package:flutter/material.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';

class EnteGobiero extends StatefulWidget{

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

  //Método que se ejecuta cuando se renderiza la interfaz
  @override
  void initState() { 
    super.initState();

    tiendasdisponibles = new List<Tienda>();
    tiendasmoderadas = new List<Tienda>();
    tiendasnoDisponibles = new List<Tienda>();

    cantidadEstablecimientos();
    Tienda().traerTiendas();
    
  }//Fin método

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
                  child: Text("Estado de los establecimientos", style: Estilos.estiloTextoTitulo),

                ),
                SizedBox(height: 15),
                Container(

                  width: 340,
                  height: 40,
                  child: Text("Para mayor información selecciona una de las siguiente opciones.", style: Estilos.estiloTextoParrafo, textAlign: TextAlign.justify),

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

                            child: Text(disponibles.toString(), style: Estilos.estiloTextoboton),
                            onPressed: (){interfazDisponible();},
                            backgroundColor: Colors.green,
                            heroTag: null,

                          ),

                        ),
                        Container(

                          width: 70,
                          height: 70,
                          child: FloatingActionButton(

                            child: Text(moderados.toString(), style: Estilos.estiloTextoboton),
                            onPressed: () {interfazModerada();},
                            backgroundColor: Colors.yellow,
                            heroTag: null,

                          ),

                        ),
                        Container(

                          width: 70,
                          height: 70,
                          child: FloatingActionButton(

                            child: Text(noDisponibles.toString(), style: Estilos.estiloTextoboton),
                            onPressed: () {interfaznoDisponible();},
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
                          child: Text("Disponibles", style: Estilos.estiloTextoEstado),

                        ),

                        Container(
                          
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text("Moderados", style: Estilos.estiloTextoEstado),

                        ),

                        Container(

                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text("No disponibles", style: Estilos.estiloTextoEstado),

                        )

                      ],

                    ),

                  ),

                ),
                SizedBox(height: 50),
                Container(

                  width: 340,
                  height: 25,
                  child: Text("Temperaturas excedidas", style: Estilos.estiloTextoTitulo),

                )

              ],

            ),

          ),

        ),

      ),

    );
  
  }

  void cantidadEstablecimientos(){

    int tamanoDatos = Tienda.tiendas.length;
    var tienda = Tienda.tiendas;

    for (var i = 0; i < tamanoDatos; i++) {

      double referencia = tienda[i].capacidad / 2;
      
      if(tienda[i].ocupado < referencia){

        disponibles++;
        tiendasdisponibles.add(tienda[i]);

      }else if(tienda[i].ocupado >= referencia && tienda[i].ocupado < tienda[i].capacidad){

        moderados++;
        tiendasmoderadas.add(tienda[i]);

      }else if(tienda[i].ocupado == tienda[i].capacidad){

        noDisponibles++;
        tiendasnoDisponibles.add(tienda[i]);

      }//Fin condición

    }//Fin for

    print("Disponibles" + disponibles.toString());
    print("Moderados" + moderados.toString());
    print("No" + noDisponibles.toString());

  }//Fin método

  void interfazDisponible(){

    if(disponibles != 0){

      Navigator.of(context).push(MaterialPageRoute(
        
        builder: (context) => EstadoTienda(tiendasdisponibles, "disponible"))
        
        );

    }

  }//Fin método

  void interfazModerada(){

    if(moderados != 0){

      Navigator.of(context).push(MaterialPageRoute(
        
        builder: (context) => EstadoTienda(tiendasmoderadas, "moderado"))
        
        );

    }

  }//Fin método

  void interfaznoDisponible(){

    if(noDisponibles != 0){

      Navigator.of(context).push(MaterialPageRoute(
        
        builder: (context) => EstadoTienda(tiendasnoDisponibles, "no disponible"))
        
        );

    }

  }//Fin método


}//Fin clase
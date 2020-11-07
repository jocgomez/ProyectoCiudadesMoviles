import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:ciudadesmoviles/Rutas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MainPaginaState createState() => _MainPaginaState();
}

class _MainPaginaState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    Tienda().traerTiendas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //AQUI SE VAN A CONFIGURAR MUCHOS ESTILOS DE LA APLICACIÓN, COMO EL  TEMA,
      //QUE INCLUYE COLORES, TIOPOGRAFIA Y MUCHO MAS
      debugShowCheckedModeBanner: false,
      title: 'Ciudades móviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/login",
      routes: rutasApp(),
    );
  }
}

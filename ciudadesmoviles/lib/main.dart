import 'package:ciudadesmoviles/Rutas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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



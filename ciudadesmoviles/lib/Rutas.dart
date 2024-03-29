import 'package:ciudadesmoviles/Paginas/Celular.dart';
import 'package:ciudadesmoviles/Paginas/Establecimiento.dart';
import 'package:ciudadesmoviles/Paginas/Gobierno.dart';
import 'package:ciudadesmoviles/Paginas/Home.dart';
import 'package:ciudadesmoviles/Paginas/Login.dart';
import 'package:ciudadesmoviles/Paginas/Mapa.dart';
import 'package:ciudadesmoviles/Paginas/Menu_Lateral.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rutasApp() => <String, WidgetBuilder>{
      '/login': (BuildContext context) => LoginPagina(),
      '/mapa': (BuildContext context) => MapaPagina(),
      '/celular': (BuildContext context) => InicioCelular(),
      '/home': (BuildContext context) => HomePagina(),
      '/menu': (BuildContext context) => MenuLateral(),
      '/Establecimientos': (BuildContext context) => Establecimientos(),
      '/Gobierno': (BuildContext context) => EnteGobiero(),
    };

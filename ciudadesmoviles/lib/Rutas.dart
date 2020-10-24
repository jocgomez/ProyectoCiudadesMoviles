import 'package:ciudadesmoviles/Paginas/Celular.dart';
import 'package:ciudadesmoviles/Paginas/Home.dart';
import 'package:ciudadesmoviles/Paginas/Login.dart';
import 'package:ciudadesmoviles/Paginas/Mapa.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rutasApp() => <String, WidgetBuilder>{
      '/login': (BuildContext context) => LoginPagina(),
      '/mapa': (BuildContext context) => MapaPagina(),
      '/celular': (BuildContext context) => InicioCelular(),
      '/home': (BuildContext context) => HomePagina(),
      //'/gobierno': (BuildContext context) => MapaPagina(),
    };

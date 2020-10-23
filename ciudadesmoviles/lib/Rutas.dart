import 'package:ciudadesmoviles/Paginas/Login.dart';
import 'package:ciudadesmoviles/Paginas/Mapa.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rutasApp() => <String, WidgetBuilder>{
      '/login': (BuildContext context) => LoginPagina(),
      '/mapa': (BuildContext context) => MapaPagina(),
      //'/gobierno': (BuildContext context) => MapaPagina(),
    };

import 'package:ciudadesmoviles/Paginas/Mapa.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rutasApp() => <String, WidgetBuilder>{
      //'/login': (BuildContext context) => HomePage(),
      '/mapa': (BuildContext context) => MapaPagina(),
    };

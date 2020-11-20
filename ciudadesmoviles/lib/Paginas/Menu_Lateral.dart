import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  color: Estilos.colorMenu,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/restaurante.png')),
                      SizedBox(height: 16.0),
                      Text(
                        "CapacidApp",
                        style: Estilos.estiloBoldBlanco18,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              _opcionMenuLateral("Mapa", Icons.location_on, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/mapa");
              }),
              Divider(),
              _opcionMenuLateral("Crear establecimiento", Icons.store, () {Navigator.pushNamed(context, "/Establecimientos");}),
              Divider(),
              _opcionMenuLateral("Cerrar sesión", Icons.exit_to_app, () {Navigator.pushNamed(context, "/login");}),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _opcionMenuLateral(String titulo, IconData icono, Function funcion) {
    return ListTile(
      title: Text(titulo, style: Estilos.estiloNormalAzul14),
      leading: Icon(
        icono,
        color: Estilos.colorPrincipal,
      ),
      onTap: funcion,
    );
  }
}

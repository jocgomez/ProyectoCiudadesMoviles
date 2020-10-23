import 'package:ciudadesmoviles/Componentes/boton.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:ciudadesmoviles/Paginas/Celular.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LoginPagina extends StatefulWidget {
  @override
  _LoginPaginaState createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {

  Location _location = Location();
  final _estiloTextoGobierno = new TextStyle(color: Colors.blue, fontSize: 17);

  @override
  void initState() {
    // TODO: implement initState
    _initLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
                width: 160,
                height: 160,
                /*color: Colors.red,*/ child:
                    Image.asset('assets/restaurante.png')),
            SizedBox(height: 15),
            Container(
                alignment: Alignment.center,
                width: 220,
                height: 40,
                /*color: Colors.blue,*/ child: Text('CapacidadApp',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center)),
            SizedBox(height: 80),
            Container(
                width: 230,
                height: 130,
                /*color: Colors.brown,*/ child: _botonesInicio()),
            SizedBox(height: 20),
            Container(
                width: 250,
                height: 40,
                /*color: Colors.cyan,*/ child: _botonGobierno()),
          ],
        ),
      ),
    );
  } //Fin clase build

  Widget _botonesInicio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
        BotonAtomo(color: Estilos.colorazul, 
                   estiloTexto: Estilos.estiloTextoBoton , 
                   texto: "Iniciar con celular", 
                   colorBorde: Estilos.bordeBoton, 
                   funcion: (){_interfazCelular();}),

        BotonAtomo(color: Estilos.colorazul, 
                   estiloTexto: Estilos.estiloTextoBoton , 
                   texto: " Iniciar con Gmail ", 
                   colorBorde: Estilos.bordeBoton, 
                   funcion: (){}),
        
        ],
    );
  }

  Widget _botonGobierno() {
    return FlatButton(
        onPressed: () {},
        child: Text(
          'Información gubernamental',
          style: _estiloTextoGobierno,
        ));
  } //Fin widget

  void _interfazCelular() {
    Navigator.of(context)
        .pushNamed("/celular");
  } //Fin método

//****************************************************************************************************/

  _initLocation() async {
    // SOLICITA PERMISOS PARA MANEJAR MAPS
    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        print("No permission");
        return;
      }
    }
  }
} //Fin clase principal

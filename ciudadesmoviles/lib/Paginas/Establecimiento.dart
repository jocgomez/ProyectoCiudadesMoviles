import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ciudadesmoviles/Componentes/boton.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:ciudadesmoviles/Modelos/Tienda.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Establecimientos extends StatefulWidget {
  _EstablecimientoState createState() => _EstablecimientoState();
}

class _EstablecimientoState extends State<Establecimientos> {
  String nombreE;
  String direccionE;
  String nitE;
  String fotoE;
  int capacidadE;
  int calificacionE;
  int longitudE;
  int latitudE;
  int ocupadoE = 0;

  File _imagenSubida;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar establecimiento"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, hintText: "Nombre"),
                    onChanged: (valor) {
                      nombreE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, hintText: "Dirección"),
                    onChanged: (valor) {
                      direccionE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true, hintText: "NIT establecimiento"),
                    onChanged: (valor) {
                      nitE = valor;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: BotonAtomo(
                    
                    color: Estilos.colorazul, 
                    estiloTexto: Estilos.estiloTextoBoton,
                    texto: "Subir imagen tienda                                                        ", 
                    colorBorde: Estilos.bordeBoton, 
                    funcion: (){

                       _subirImagen();

                    }),
              
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true, hintText: "Máxima capacidad"),
                    onChanged: (valor) {
                      capacidadE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(filled: true, hintText: "Calificación"),
                    onChanged: (valor) {
                      calificacionE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(filled: true, hintText: "Longitud"),
                    onChanged: (valor) {
                      longitudE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(filled: true, hintText: "Latitud"),
                    onChanged: (valor) {
                      latitudE = int.parse(valor);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  width: 360,
                  height: 50,
                  child: BotonAtomo(
                      color: Estilos.colorazul,
                      estiloTexto: Estilos.estiloTextoBoton,
                      texto: "Guardar establecimiento",
                      colorBorde: Estilos.bordeBoton,
                      funcion: () {
                        _guardarDatos();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } //Fin Widget

  void _guardarDatos() async {
    
    if(nombreE == null){

      _mensajeAdvertencia("Ingresar el nombre de la tienda");
      print("Entro nombre");

    }else if(direccionE == null){

      _mensajeAdvertencia("Ingresar la dirección");

    }else if(nitE == null){

      _mensajeAdvertencia("Ingresar el NIT de la tienda");
      print("Entro nit");

    }else if(capacidadE == null){

      _mensajeAdvertencia("Ingresar la capacidad máxima");

    }else if(calificacionE == null){

      _mensajeAdvertencia("Ingresar la calificación para la tienda");

    }else if(longitudE == null){

      _mensajeAdvertencia("Ingresar el valor de la longitud");

    }else if(latitudE == null){

      _mensajeAdvertencia("Ingresar el valor de la latitud");

    }else if(_imagenSubida == null){

      _mensajeAdvertencia("Subir la foto para la tienda");

    }else{

    var json = {};

    json['nombre'] = nombreE;
    json['direccion'] = direccionE;
    json['nit'] = nitE;
    json['foto'] = fotoE;
    json['capacidad'] = capacidadE;
    json['calificacion'] = calificacionE;
    json['longitud'] = longitudE;
    json['latitud'] = latitudE;
    json['ocupado'] = ocupadoE;

    String establecimiento = jsonEncode(json);

    final response = await Tienda().guardarEstablecimiento(establecimiento);

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Confirmación guardado"),
                content: Text(
                    "Los datos del establecimiento se guardaron adecuadamente."),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Aceptar"))
                ],
              ));
    } //Fin condición if
  
  }//Fin condición IF
  
  } //Fin método

  void _subirImagen() async{

    var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imagenSubida = imagen;
    });

    if(_imagenSubida != null){

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Confirmación imagen"),
                content: Text(
                    "La imagen selecciona fue subida correctamente."),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Aceptar"))
                ],
              ));

      var nombreImagen = Uuid().v1();
      var imagenRuta = "/tiendas/$nombreImagen.jpg";

      final StorageReference storageReference = FirebaseStorage().ref().child(imagenRuta);

      final StorageUploadTask uploadTask = storageReference.putFile(_imagenSubida);

      final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
        
        print('EVENT ${event.type}');

      });

      await uploadTask.onComplete;
      streamSubscription.cancel();

      //Se guardar el link en el campo foto para la tienda
      fotoE = (await storageReference.getDownloadURL()).toString();

    }else{

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Confirmación imagen"),
                content: Text(
                    "La imagen selecciona no fue subida correctamente. Vuelva a subir la imagen."),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Aceptar"))
                ],
              ));

    }//Fin condición if

  }//Fin método

  void _mensajeAdvertencia(String cadena){

    showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Advertencia información"),
                content: Text(cadena),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Aceptar"))
                ],
              ));

  }//Fin método

}

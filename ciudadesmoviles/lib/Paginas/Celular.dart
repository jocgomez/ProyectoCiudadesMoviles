import 'package:ciudadesmoviles/Componentes/boton.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class InicioCelular extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _InicioCelularState();
  
  }//Fin método

}//Fin clase

class _InicioCelularState extends State{

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(

        title: Text('Inicio sesión con celular'),

      ),

      body: Center(

        child: Column(

          children: [

            SizedBox(height: 75),
            Container(
                width: 160,
                height: 160,
                /*color: Colors.red,*/ 
                child: Image.asset('assets/restaurante.png')),
            SizedBox(height: 15),
            Container(
                alignment: Alignment.center,
                width: 220,
                height: 40,
                /*color: Colors.blue,*/ 
                child: Text('CapacidadApp',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center)),
            SizedBox(height: 60),
            Container(
              width: 220,
              height: 20,
              /*color: Colors.yellow,*/
              child: Text('N° celular', style: Estilos.estiloTextoCelular)),
            SizedBox(height: 10),
            Container(
              width: 220,
              height: 45,
              /*color: Colors.blue,*/
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.phone_android)
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 250,
              height: 20,
              /*color: Colors.deepOrange,*/
              child: Text('Ingrese el código de verificación', style: Estilos.estiloTextoCelular),
            ),
            SizedBox(height: 10),
            Container(
              width: 240,
              height: 50,
              /*color: Colors.green,*/
              child: PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (codigo){

                  print(codigo);

                },
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 240,
              height: 50,
              color: Colors.lime,
              child:  BotonAtomo(color: Estilos.colorazul, 
                   estiloTexto: Estilos.estiloTextoBoton , 
                   texto: "Iniciar sesión", 
                   colorBorde: Estilos.bordeBoton, 
                   funcion: (){})
            )

          ],

        ),

      ),

    );

  }//Fin Widget

}//Fin clase
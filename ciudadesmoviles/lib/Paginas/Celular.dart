import 'package:ciudadesmoviles/Componentes/boton.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InicioCelular extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InicioCelularState();
  } //Fin método

} //Fin clase

class _InicioCelularState extends State {
  String codigoFirebase;
  String codigoUsuario;
  String verificacionId;

  final codigo1 = TextEditingController();

  Future<void> autenticacionUsuario(String numeroTelefono) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieval = (String verId) {
      this.verificacionId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificacionId = verId;
    };

    final PhoneVerificationCompleted verificationSucess =
        (AuthCredential credential) async {
      AuthResult resultados =
          await FirebaseAuth.instance.signInWithCredential(credential);

      FirebaseUser usuario = resultados.user;

      if (usuario != null) {
        Navigator.of(context).pushNamed("/tarjeta");
      } else {
        print("error");
      } //Fin condición
    };

    final PhoneVerificationFailed verficationFail = (AuthException exception) {
      print("Error , ${exception.message}");
    };

    print("Número telefono: " + numeroTelefono);

    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: numeroTelefono,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationSucess,
        verificationFailed: verficationFail,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieval);
  } //Fin método

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SizedBox(height: 90),
            Container(
              width: 220,
              height: 45,
              /*color: Colors.blue,*/
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "N° celular",
                    prefixIcon: Icon(Icons.phone_android)),
                onChanged: (numero) {
                  if (numero.length == 10) {
                    print(numero);
                    autenticacionUsuario("+57" + numero);
                  } //Fin condición
                },
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 250,
              height: 20,
              /*color: Colors.deepOrange,*/
              child: Text('Ingrese el código de verificación',
                  style: Estilos.estiloTextoCelular),
            ),
            SizedBox(height: 10),
            Container(
              width: 240,
              height: 50,
              /*color: Colors.green,*/
              child: PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (codigo) {
                  codigoUsuario = codigo1.text;
                },
                controller: codigo1,
              ),
            ),
            SizedBox(height: 40),
            Container(
                width: 240,
                height: 50,
                color: Colors.lime,
                child: BotonAtomo(
                    color: Estilos.colorazul,
                    estiloTexto: Estilos.estiloTextoBoton,
                    texto: "Iniciar sesión",
                    colorBorde: Estilos.bordeBoton,
                    funcion: () {
                      _ingresarSesion();
                    }))
          ],
        ),
      ),
    );
  } //Fin Widget

  void _ingresarSesion() async {
    if (codigoUsuario.length != 0) {
      AuthCredential credenciales = PhoneAuthProvider.getCredential(
          verificationId: this.verificacionId, smsCode: codigoUsuario);
      AuthResult resultados =
          await FirebaseAuth.instance.signInWithCredential(credenciales);

      FirebaseUser user = resultados.user;

      if (user != null) {
        Navigator.of(context).pushNamed("/tarjeta");
      } else {
        print("error");
      } //Fin condición

    } //Fin condición
  } //Fin método

} //Fin clase

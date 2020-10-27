import 'package:flutter/material.dart';
import 'package:ciudadesmoviles/Estilos/Estilos.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Tarjeta extends StatelessWidget {
  Tarjeta(
      {Key key,
      @required this.nombre,
      @required this.direccion,
      @required this.calificacion,
      @required this.foto,
      @required this.capacidad,
      @required this.colorCapacidad})
      : super(key: key);

  final String nombre;
  final String direccion;
  final double calificacion;
  final String foto;
  final String capacidad;
  final Color colorCapacidad;

  Widget _crearEstrellas(double calificacion) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 10.0,
        children: <Widget>[
          RatingBar(
            initialRating: calificacion,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20.0,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              size: 16.0,
              color: Colors.amber,
            ),
            tapOnlyMode: true,
            ignoreGestures: true,
            onRatingUpdate: (value) {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4.0, color: this.colorCapacidad),
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.nombre,
                          style: Estilos.estiloTextoCelular,
                        ),
                        Text(
                          this.direccion,
                          style: Estilos.estiloTextoCelular,
                        ),
                        _crearEstrellas(this.calificacion),
                        Row(
                          children: [
                            Text(this.capacidad,
                                style: Estilos.estiloTextoCelular),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(this.foto)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

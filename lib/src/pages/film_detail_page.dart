import 'package:films/src/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Text('Hola'),
      ),
    );
  }
}

import 'package:films/src/providers/films_provider.dart';
import 'package:films/src/widgets/card_swiper_widget_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('En Cartelera'),
          backgroundColor: Colors.indigoAccent,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: Container(
          child: SafeArea(
            child: Column(
              children: [
                _cardWidgetProvider(),
              ],
            ),
          ),
        ));
  }

  Widget _cardWidgetProvider() {
    final provider = new FilmsProvider();

    return FutureBuilder(
      future: provider.getNowPlaying(),
      builder: (BuildContext constext, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidgetProvider(films: snapshot.data);
        } else {
          return Container(
            height: 400,
              child: Center(child: CircularProgressIndicator())
          );
        }
      },
    );
  }
}

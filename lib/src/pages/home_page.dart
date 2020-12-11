import 'package:films/src/providers/films_provider.dart';
import 'package:films/src/widgets/card_swiper_widget_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final provider = new FilmsProvider();

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_cardWidgetProvider(provider), _footer(context, provider)],
            ),
          ),
        ));
  }

  Widget _cardWidgetProvider(FilmsProvider provider) {

    return FutureBuilder(
      future: provider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidgetProvider(films: snapshot.data);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context, FilmsProvider provider) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            // Text('Populares', style: Theme.of(context).textTheme.subtitle1,),
            Text(
              'Populares',
              style: Theme.of(context).textTheme.headline6,
            ),
            FutureBuilder(
              future: provider.getPopular(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  snapshot.data.forEach((film) => {
                    film.title
                  });
                }
                return Container();
              },
            )
          ],
        ));
  }
}

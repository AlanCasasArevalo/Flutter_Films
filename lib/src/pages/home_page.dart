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
    return CardSwiperWidgetProvider(films: [
      1,2,3,4,5
    ]);
  }
}

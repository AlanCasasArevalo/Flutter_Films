import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
                _cardProvider(),
              ],
            ),
          ),
        ));
  }

  Widget _cardProvider() {
    Swiper _swiper = new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          "http://via.placeholder.com/350x150",
          fit: BoxFit.fill,
        );
      },
      itemCount: 3,
      // pagination: new SwiperPagination(),
      // control: new SwiperControl(),
      layout: SwiperLayout.STACK,
      itemWidth: 300,
    );

    return Container(padding: EdgeInsets.only(top: 20),width: double.infinity, height: 250, child: _swiper);
  }
}

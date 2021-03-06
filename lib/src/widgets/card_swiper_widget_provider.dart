import 'package:films/src/models/film_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidgetProvider extends StatelessWidget {
  final List<Film> films;

  CardSwiperWidgetProvider({ @required this.films });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    Swiper _swiper = new Swiper(
      itemBuilder: (BuildContext context, int index) {
        films[index].uniqueId = '${films[index].id}-main-card';
        return Hero(
          tag: films[index].uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GestureDetector(
              child: FadeInImage(
                image: NetworkImage(films[index].getPosterImage()),
                placeholder: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'film_detail', arguments: films[index]);
              },
            ),
          ),
        );
      },
      itemCount: films.length,
      layout: SwiperLayout.STACK,
      itemWidth: _screenSize.width * 0.7,
      itemHeight: _screenSize.height * 0.5,
    );

    return Container(
        padding: EdgeInsets.only(top: 20),
        child: _swiper
    );
  }
}
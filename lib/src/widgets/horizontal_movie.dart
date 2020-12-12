import 'package:films/src/models/film_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HorizontalMovie extends StatelessWidget {
  final List<Film> films;

  HorizontalMovie({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.20,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return films.map((film) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(film.getPosterImage()),
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
                film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}

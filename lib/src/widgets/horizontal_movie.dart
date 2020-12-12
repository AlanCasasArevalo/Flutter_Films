import 'package:films/src/models/film_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HorizontalMovie extends StatelessWidget {
  final List<Film> films;

  final Function nextPage;

  HorizontalMovie({@required this.films, @required this.nextPage});

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 175) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.20,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
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
                height: 150,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
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
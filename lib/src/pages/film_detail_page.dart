import 'package:films/src/models/film_model.dart';
import 'package:films/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {
  final provider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;

    provider.getActors(film.id.toString());

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            _appBarBuilder(film),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              _titlePoster(context, film),
              _descriptionFilm(film),
            ]))
          ],
        ),
      ),
    );
  }

  Widget _descriptionFilm(Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        film.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _titlePoster(BuildContext context, Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(film.getPosterImage()),
              height: 150,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(film.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis),
              Text(
                film.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(film.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  SliverAppBar _appBarBuilder(Film film) {
    return SliverAppBar(
      elevation: 30,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          film.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          image: NetworkImage(film.getBackdropPathImage()),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

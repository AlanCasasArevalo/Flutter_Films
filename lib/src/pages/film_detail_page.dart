import 'package:films/src/models/actor_model.dart';
import 'package:films/src/models/film_model.dart';
import 'package:films/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {
  final provider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;

    provider.getActors(film.id);

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
              _castingBuilder(film)
            ]))
          ],
        ),
      ),
    );
  }

  Widget _castingBuilder(Film film) {
    final provider = new FilmsProvider();

    provider.getActors(film.id);

    return FutureBuilder(
      future: provider.getActors(film.id),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _actorsPageViewBuilder(snapshot.data);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _actorsPageViewBuilder(List<Actor> actors) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
          pageSnapping: false,
          itemCount: actors.length,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, index) {
            return _actorCardBuilder(actors[index]);
          }),
    );
  }

  Widget _actorCardBuilder(Actor actor) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.getPosterImage()),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold
            )
          )
        ],
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
          Hero(
            tag: film.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(film.getPosterImage()),
                height: 150,
              ),
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

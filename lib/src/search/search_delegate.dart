import 'package:films/src/models/film_model.dart';
import 'package:films/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selected = '';

  final films = [
    'Spiderman',
    'Capitan america',
    'Ironman',
    'Superman',
    'Shazam',
    'Jiu Jitsu',
    'Algo normal'
  ];

  final recentFilms = ['Spiderman', 'Capitan america', 'Ironman'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono de la izquierda
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Center(
        child: Container(
      height: 100,
      width: 100,
      color: Colors.amberAccent,
      child: Text(selected),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Crea las sugerencias cuando la persona escribe
    final provider = FilmsProvider();

    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: provider.getSearchFilm(query),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final List<Film> films = snapshot.data;
            return _listViewResultBuilder(context, films);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }

  ListView _listViewResultBuilder(BuildContext context, List<Film> films) {
    return ListView(
      children: films.map((film) {
        return ListTile(
          leading: FadeInImage(
            image: NetworkImage(film.getPosterImage()),
            placeholder: AssetImage('assets/no-image.jpg'),
            width: 50,
            fit: BoxFit.contain,
          ),
          title: Text(film?.title),
          subtitle: Text('Votación ${film?.voteAverage}'),
          onTap: () {
            close(context, null);
            film.uniqueId = '${film.id}-film-searched';
            Navigator.pushNamed(context, 'film_detail', arguments: film);
          },
        );
      }).toList(),
    );
  }
}

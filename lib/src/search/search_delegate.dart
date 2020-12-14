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
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Crea las sugerencias cuando la persona escribe

    final suggestionList = (query.isEmpty) ? recentFilms : films.where(
            // Se puede usar el contiene o bien el startsWith
            // (element) => element.toLowerCase().startsWith(query.toLowerCase())
            (element) => element.toLowerCase().contains(query.toLowerCase())
    ).toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(suggestionList[index]),
            onTap: () {
              selected = suggestionList[index];
              showResults(context);
            },
          );
        });
  }
}

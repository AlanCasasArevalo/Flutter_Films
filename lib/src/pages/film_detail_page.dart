import 'package:films/src/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            _appBarBuilder(film),
          ],
        ),
      ),
    );
  }

  SliverAppBar _appBarBuilder (Film film) {
    return SliverAppBar(
      elevation: 30,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(film.title, style: TextStyle(color: Colors.white, fontSize: 16),),
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

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
final Function siguientePagina;
  //definirlo en el constructor
  MovieHorizontal({@required this.peliculas,  @required this.siguientePagina});


  //propiedad
  final _pagesController = new PageController(
      initialPage: 1,
          viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    //Listener escuchara cambios
    _pagesController.addListener((){

      if(_pagesController.position.pixels >= _pagesController.position.maxScrollExtent - 200){
       siguientePagina();
      }

    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false,
        controller: _pagesController,
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
              ),
          ],
        ),
      );
    }).toList();
  }
}

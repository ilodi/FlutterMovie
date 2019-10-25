import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swipperTarjetas(),
          ],
        ),
      ),
    );
  }

  Widget _swipperTarjetas() {
    return Container(
        //USA TODO EL WIDTH POSIBLE
        width: double.infinity,
        height: 300.0,
        padding: EdgeInsets.only(top:20.0),
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: 300.0,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              "http://via.placeholder.com/350x150",
              fit: BoxFit.fill,
            );
          },
          itemCount: 3,
          pagination: new SwiperPagination(),
          control: new SwiperControl(color: Colors.red)
        ));
  }
}

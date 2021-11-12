// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  // TODO Cambiar luego por una instancia de movie
  final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _OverView(),
              CastingCards(),
            ])
          )
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: Text(
            'movie.title',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

  final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title', 
                style:textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2
              ),
              Text(
                'movie.orginalTitle', 
                style:textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  SizedBox(width: 5),
                  Text('movie.voteAverage', style: textTheme.caption)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quam mauris, vestibulum ac tempor ut, suscipit in justo. Proin lectus lectus, posuere nec ipsum ut, tempus imperdiet massa. Quisque odio lorem, egestas eu volutpat vel, commodo nec arcu. Duis odio erat, dictum quis dolor et, condimentum semper velit. Duis ut dui quam. Nunc vel tempus mauris, nec porttitor eros. Donec ornare risus non feugiat finibus. Etiam faucibus vel sem non condimentum. Sed non dignissim est. Nullam bibendum eu orci dignissim posuere.',
        textAlign: TextAlign.justify,
        style: textTheme.subtitle1,
      ),
      
    );
  }
}
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LatestMovieList extends StatefulWidget {
  String? imageUrl;
  String movieName;
  double rating;
  LatestMovieList(
      {this.imageUrl,
      required this.rating,
      required this.movieName,
      super.key});

  @override
  State<LatestMovieList> createState() => _LatestMovieListState();
}

class _LatestMovieListState extends State<LatestMovieList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 1,
      height: 180,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            color: Colors.white,
          ),
          //the api might return a null image as a response  i don't want the app crash
          image: widget.imageUrl == null
              ? const DecorationImage(
                  image: AssetImage('images/erorr_image.png'))
              : DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${widget.imageUrl}'))),
    );
  }
}

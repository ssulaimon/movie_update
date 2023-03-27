import 'package:flutter/material.dart';
import 'package:movie_update/api/get_Movies.dart';
import 'package:movie_update/models/movies_details.dart';

import 'latest_movie_list.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  String keyword;
  SearchScreen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Search Result',
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MoviesDetails> movie = snapshot.data as List<MoviesDetails>;
            return GridView.builder(
              itemCount: movie.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 200 / 300,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async => getDetails(
                    context: context,
                    title: movie[index].name,
                    overView: movie[index].overView,
                    rating: movie[index].rating.toString(),
                  ),
                  child: LatestMovieList(
                    imageUrl: movie[index].image,
                    rating: movie[index].rating,
                    movieName: movie[index].name,
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Image.asset(
              'images/erorr_image.png',
            );
          }
        },
        future: GetMovies.searchMovie(
          searchWord: widget.keyword,
        ),
      ),
    );
  }
}

Future<void> getDetails({
  required BuildContext context,
  required String title,
  required String overView,
  required String rating,
}) async {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  await showDialog(
      context: (context),
      builder: (_) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: SizedBox(
            height: height * 0.4,
            width: width * 0.5,
            child: ListView(
              children: [
                const Text(
                  'About movie',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(overView),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Rating',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(rating)
              ],
            ),
          ),
        );
      });
}

import 'package:flutter/material.dart';
import 'package:movie_update/api/get_Movies.dart';
import 'package:movie_update/models/movies_details.dart';
import 'package:movie_update/screen/latest_movie_list.dart';
import 'package:movie_update/screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: height * 0.15,
        title: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(keyword: value),
                    ),
                  );
                }
              },
              decoration: const InputDecoration(
                hintText: "Search for movie",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'Treding Movies',
                ),
                Tab(
                  text: "TV Series",
                )
              ],
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ViewsMovies(
            mediaType: 'movie',
          ),
          ViewsMovies(mediaType: 'tv')
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ViewsMovies extends StatelessWidget {
  String mediaType;
  ViewsMovies({super.key, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetMovies.getLatestMovies(
        mediaType: mediaType,
      ),
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
          return const Center(child: CircularProgressIndicator());
        } else {
          return Image.asset(
            'images/erorr_image.png',
          );
        }
      },
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

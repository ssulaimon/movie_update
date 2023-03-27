class MoviesDetails {
  String name;
  String? image;
  double rating;
  String overView;
  MoviesDetails({
    required this.overView,
    required this.name,
    required this.rating,
    this.image,
  });
}

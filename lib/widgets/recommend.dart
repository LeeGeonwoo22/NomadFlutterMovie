import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/models/movies_model.dart';
import 'package:flutter_movie_app_origin/service/api_service.dart';

class RecommendWidget extends StatefulWidget {
  const RecommendWidget({super.key});

  @override
  State<RecommendWidget> createState() => _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {
  late Future<List<MovieModel>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        FutureBuilder(
            future: movies,
            builder: (context, AsyncSnapshot<List<MovieModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading data: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (snapshot.hasData) {
                final List<MovieModel> movieList = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var movie in movieList)
                        Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                movie.posterPath,
                                height: 100,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ))
                    ],
                  ),
                );
              } else {
                return const SizedBox(
                  height: 20,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            })
      ],
    );
  }
}
// InkWell(
//                   onTap: () {},
//                 ),
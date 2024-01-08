import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/models/coming_model.dart';
import 'package:flutter_movie_app_origin/service/api_service.dart';

class ComingMovieWidget extends StatefulWidget {
  const ComingMovieWidget({Key? key}) : super(key: key);

  @override
  _ComingMovieWidgetState createState() => _ComingMovieWidgetState();
}

class _ComingMovieWidgetState extends State<ComingMovieWidget> {
  late Future<List<ComingModel>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.getComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
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
          builder: (context, AsyncSnapshot<List<ComingModel>> snapshot) {
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
              final List<ComingModel> movieList = snapshot.data!;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var movie in movieList)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                movie.posterPath,
                                height: 180,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    8), // Add spacing between image and text
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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
          },
        )
      ],
    );
  }
}

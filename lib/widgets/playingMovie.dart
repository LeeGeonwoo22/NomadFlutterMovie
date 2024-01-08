// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/models/now_model.dart';
import 'package:flutter_movie_app_origin/service/api_service.dart';

class PlayingMovieWidget extends StatefulWidget {
  const PlayingMovieWidget({super.key});

  @override
  State<PlayingMovieWidget> createState() => _PlayingMovieWidgetState();
}

class _PlayingMovieWidgetState extends State<PlayingMovieWidget> {
  late Future<List<PlayingModel>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.getPlayingMovies();
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
                "Playing Movies",
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
          builder: (context, AsyncSnapshot<List<PlayingModel>> snapshot) {
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
              final List<PlayingModel> movieList = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var movie in movieList)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "moviePage",
                            arguments: movie,
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 300,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xFF292B37),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF292B37)
                                        .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  movie.posterPath,
                                  height: 200,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      maxLines:
                                          2, // 표시할 최대 라인 수 (1로 설정하여 한 줄만 표시)
                                      overflow:
                                          TextOverflow.ellipsis, // 생략 부호를 표시
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // Text(
                                    //   movie.genreIds,
                                    //   style: const TextStyle(
                                    //     color: Colors.white54,
                                    //     fontSize: 15,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    //   textAlign: TextAlign.center,
                                    // ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          movie.voteAverage.toStringAsFixed(1),
                                          style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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

// https://youtu.be/k0VYphWKm4I?t=1041

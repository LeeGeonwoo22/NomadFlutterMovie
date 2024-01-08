import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/models/movies_model.dart';
import 'package:flutter_movie_app_origin/service/api_service.dart';
import 'package:flutter_movie_app_origin/widgets/customNavbar.dart';
import 'package:flutter_movie_app_origin/widgets/moviePageButton.dart';
import 'package:flutter_movie_app_origin/widgets/recommend.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late Future<List<MovieModel>> movies;
  late MovieModel selectedMovie;

  @override
  void initState() {
    super.initState();
    movies = ApiService.getMovies();
  }

  void onMovieSelected(MovieModel movie) {
    setState(() {
      selectedMovie = movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
            return Stack(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Column(
                    children: [
                      for (var movie in movieList)
                        if (selectedMovie == movie)
                          Image.network(
                            movie.posterPath,
                            height: 280,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: SafeArea(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var movie in movieList)
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                      )
                                    ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(movie.backdropPath),
                                ),
                              ),
                            Container(
                              margin: const EdgeInsets.only(right: 50, top: 70),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 8)
                                  ]),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 60,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const MoviePageButtons(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedMovie.title, // null 체크 추가
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              selectedMovie.overview, // null 체크 추가
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const RecommendWidget(),
                    ],
                  )),
                )
              ],
            );
          } else {
            return const SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      // Stack(
      //   children: [Image.network()],
      // ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

// ignore: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/models/movies_model.dart';
import 'package:flutter_movie_app_origin/service/api_service.dart';

class PopularMoviegWidget extends StatefulWidget {
  const PopularMoviegWidget({Key? key}) : super(key: key);

  @override
  _PopularMoviegWidgetState createState() => _PopularMoviegWidgetState();
}

class _PopularMoviegWidgetState extends State<PopularMoviegWidget> {
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text(
              //   "See All",
              //   style: TextStyle(
              //     color: Colors.white54,
              //     fontSize: 16,
              //   ),
              // ),
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
              return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: movieList.map((movie) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // constraints를 통해 Container의 크기를 확인할 수 있습니다.
                      double containerHeight = constraints.maxHeight;

                      return Container(
                        height: containerHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image(
                                image: NetworkImage(movie.posterPath),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              movie.title,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}

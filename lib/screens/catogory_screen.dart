import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/models/movies_model.dart';
import 'package:flutter_movie_app_origin/service/api_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<MovieModel>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Discover",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
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
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          for (var movie in movieList)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      movie.posterPath,
                                      height: 70,
                                      width: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    wrapText(movie.title),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                        ],
                      ));
                } else {
                  return const SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

String wrapText(String text) {
  // "-" 또는 ":" 중 어떤 것이 먼저 나오는지 확인
  RegExpMatch? match = RegExp(r'[-:&]').firstMatch(text);

  if (match != null) {
    // 먼저 나온 것을 기준으로 문자열을 나누기
    String separator = match.group(0)!;
    List<String> parts = text.split(separator);

    // 각 부분을 다시 합치면서 줄 바꿈 추가
    String wrappedText = parts.join('\n');

    return wrappedText;
  } else {
    // "-"나 ":"가 없을 경우 원래 문자열 반환
    return text;
  }
}

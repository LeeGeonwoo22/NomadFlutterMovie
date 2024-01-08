import 'package:flutter/material.dart';
import 'package:flutter_movie_app_origin/widgets/comingMovie.dart';
import 'package:flutter_movie_app_origin/widgets/customNavbar.dart';
import 'package:flutter_movie_app_origin/widgets/playingMovie.dart';
import 'package:flutter_movie_app_origin/widgets/popularMovie.dart';

// ignore: depend_on_referenced_packages
// import '';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello World',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'What to Watch?',
                        style: TextStyle(color: Colors.white54),
                      )
                    ],
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                    semanticLabel: 'Edit User',
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF292837),
              ),
              child: Row(children: [
                const Icon(
                  Icons.search,
                  color: Colors.white54,
                  size: 30,
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white54)),
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            const ComingMovieWidget(),
            const SizedBox(
              height: 30,
            ),
            const PlayingMovieWidget(),
            const SizedBox(
              height: 30,
            ),
            const PopularMoviegWidget(),
            const SizedBox(
              height: 30,
            )
          ],
        )),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

import 'dart:convert';
import 'package:flutter_movie_app_origin/models/coming_model.dart';
import 'package:flutter_movie_app_origin/models/movies_model.dart';
import 'package:flutter_movie_app_origin/models/now_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String coming = "coming-soon";

  static Future<List<MovieModel>> getMovies() async {
    try {
      List<MovieModel> movieInstances = [];
      final url = Uri.parse("$baseUrl/$popular");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> movies = responseBody['results'];
        for (var movie in movies) {
          final video = MovieModel.fromJson(movie);
          // print(video.title);
          movieInstances.add(video);
        }
        return movieInstances;
      } else {
        // print("Failed to load data. Status code: ${response.statusCode}");
        throw Exception("Failed to load data");
      }
    } catch (error) {
      // print("Error during API call: $error");
      throw Exception("Error during API call");
    }
  }

  static Future<List<PlayingModel>> getPlayingMovies() async {
    try {
      List<PlayingModel> movieInstances = [];
      final url = Uri.parse("$baseUrl/$nowPlaying");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> movies = responseBody['results'];
        for (var movie in movies) {
          final video = PlayingModel.fromJson(movie);
          // ignore: avoid_print
          print(video.genreIds);
          movieInstances.add(video);
        }
        return movieInstances;
      } else {
        // print("Failed to load data. Status code: ${response.statusCode}");
        throw Exception("Failed to load data");
      }
    } catch (error) {
      // Print more details about the error
      print("Error during API call: $error");

      // Print response body if available
      if (error is http.Response) {
        print("Response body: ${error.body}");
      }

      // Rethrow the exception for higher-level handling
      throw Exception("Error during API call: $error");
    }
  }

  static Future<List<ComingModel>> getComingMovies() async {
    try {
      List<ComingModel> movieInstances = [];
      final url = Uri.parse("$baseUrl/$coming");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> movies = responseBody['results'];
        for (var movie in movies) {
          final video = ComingModel.fromJson(movie);
          // print(video.title);
          movieInstances.add(video);
        }
        return movieInstances;
      } else {
        // print("Failed to load data. Status code: ${response.statusCode}");
        throw Exception("Failed to load data");
      }
    } catch (error) {
      // Print more details about the error
      print("Error during API call: $error");

      // Print response body if available
      if (error is http.Response) {
        print("Response body: ${error.body}");
      }

      // Rethrow the exception for higher-level handling
      throw Exception("Error during API call: $error");
    }
  }
}

import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanime_info/network/rest_client.dart';
import 'package:myanime_info/repositories/category_repository.dart';
import 'package:myanime_info/repositories/media_repository.dart';
import 'package:myanime_info/screens/anime_detail_screen.dart';
import 'package:myanime_info/screens/media_list_screen.dart';
import 'package:myanime_info/screens/home_page_screen.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => CategoryRepository(
            restClient: RestClient(Dio()),
          ),
        ),
        RepositoryProvider(
          create: (_) => MediaRepository(
            restClient: RestClient(Dio()),
          ),
        )
      ],
      child: MaterialApp(
        title: 'MyAnimeInfo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        home: AnimatedSplash(
          imagePath: 'assets/img/logo.png',
          home: HomePage(),
          duration: 2500,
          type: AnimatedSplashType.StaticDuration,
        ),
        routes: {
          HomePage.routeName: (_) => HomePage(),
          MediaListScreen.routeName: (_) => MediaListScreen(),
          AnimeDetailScreen.routeName: (_) => AnimeDetailScreen()
        },
      ),
    );
  }
}

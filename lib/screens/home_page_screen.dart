import 'package:flutter/material.dart';
import 'package:myanime_info/widgets/anime_search.dart';
import 'package:myanime_info/widgets/category_list.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home-page";

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _tabWidget(context);
  }

  Widget _tabWidget(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.search),
                  text: "Search",
                ),
                Tab(icon: Icon(Icons.list), text: "Categories"),
              ],
            ),
            centerTitle: true,
            title: Text("My Anime Info"),
          ),
          body: TabBarView(
            children: [
              AnimeSearch(),
              CategoryList(),
            ],
          ),
        ),
      );
}

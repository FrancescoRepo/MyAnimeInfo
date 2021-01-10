import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myanime_info/bloc/media/media_bloc.dart';
import 'package:myanime_info/widgets/media_list.dart';

class MediaListScreen extends StatefulWidget {
  static const String routeName = "/anime-list";

  MediaListScreen({Key key}) : super(key: key);

  @override
  _MediaListScreenState createState() => _MediaListScreenState();
}

class _MediaListScreenState extends State<MediaListScreen>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MediaListScreen> {
  TabController _tabController;
  String _categoryName;

  final List<Tab> _tabs = <Tab>[
    new Tab(
      text: 'Anime',
      icon: Icon(Icons.slideshow),
    ),
    new Tab(
      text: 'Manga',
      icon: Icon(Icons.menu_book_outlined),
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _categoryName = ModalRoute.of(context).settings.arguments as String;
    super.build(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("My Anime Info - $_categoryName"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MediaList(
            mediaType: MediaType.Anime,
            searchType: SearchType.CATEGORY_SEARCH,
            queryString: _categoryName,
          ),
          MediaList(
            mediaType: MediaType.Manga,
            searchType: SearchType.CATEGORY_SEARCH,
            queryString: _categoryName,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

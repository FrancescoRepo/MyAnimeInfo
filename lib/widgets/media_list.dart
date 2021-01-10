import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanime_info/bloc/media/media_bloc.dart';
import 'package:myanime_info/models/media.dart';
import 'package:myanime_info/models/pageinfo.dart';
import 'package:myanime_info/repositories/media_repository.dart';
import 'package:myanime_info/screens/anime_detail_screen.dart';
import 'package:myanime_info/utils/constants.dart';
import 'package:myanime_info/utils/detail_argument.dart';
import 'package:myanime_info/widgets/media_error.dart';

class MediaList extends StatefulWidget {
  MediaList({Key key, this.queryString, this.searchType, this.mediaType})
      : super(key: key);

  final String queryString;
  final SearchType searchType;
  final MediaType mediaType;

  @override
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList>
    with AutomaticKeepAliveClientMixin<MediaList> {
  bool _isLoading;
  String _searchTitle = "";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(widget.searchType == SearchType.MEDIA_SEARCH) {
      return _buildList();
    }

    return BlocProvider(
      create:(_) => MediaBloc(mediaRepository: RepositoryProvider.of<MediaRepository>(context))..fetchMedia(
          widget.queryString, widget.mediaType.inString.toUpperCase(), "1"),
      lazy: false,
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return BlocBuilder<MediaBloc, MediaState>(
      builder: (BuildContext ctx, MediaState state) {
        print(widget.queryString);
        if (state is FetchedMediaState) {
          if(state.searchTitle != null && state.searchTitle.isNotEmpty) _searchTitle = state.searchTitle;
          _isLoading = false;
          return state.mediaPage.media.length > 0
              ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      if (!_isLoading && state.mediaPage.pageInfo.hasNextPage) {
                        _isLoading = true;
                        loadMore(ctx, state.mediaPage.pageInfo);
                      }
                    }
                    return false;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          key: widget.searchType == SearchType.CATEGORY_SEARCH
                              ? PageStorageKey(widget.mediaType.inString)
                              : ValueKey(widget.mediaType.inString),
                          itemCount: state.mediaPage.media.length + 1,
                          itemBuilder: (context, index) {
                            if (index == state.mediaPage.media.length && state.mediaPage.pageInfo.hasNextPage) {
                              return Container(
                                padding: const EdgeInsets.all(4),
                                child: Center(
                                  child: Column(
                                    children: [
                                      CircularProgressIndicator(),
                                      Text(
                                        "Loading more...",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            if (index < state.mediaPage.media.length) {
                              final item = state.mediaPage.media[index];
                              return _cardItem(context, item);
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        }

        if (state is MediaErrorState) {
          return MediaErrorWidget(
            message: Constants.ERROR,
          );
        }

        if (state is FetchingMediaState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }

  Widget _cardItem(BuildContext context, Media item) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: _makeListTile(context, item),
      ),
    );
  }

  Widget _makeListTile(BuildContext context, Media item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Image.network(
          item.coverImage,
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(
              widget.mediaType == MediaType.Anime
                  ? Icons.slideshow
                  : Icons.menu_book_outlined,
              color: Colors.yellowAccent),
          Text(" " + item.type, style: TextStyle(color: Colors.white))
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () async {
        bool hasConnection = await DataConnectionChecker().hasConnection;
        if (hasConnection) {
          Navigator.of(context).pushNamed(
            AnimeDetailScreen.routeName,
            arguments:
                MediaDetailScreenArgument(media: item, type: widget.mediaType),
          );
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Please check internet connectivity")));
        }
      },
    );
  }

  void loadMore(BuildContext context, PageInfo pageInfo) {
    int newPage = pageInfo.currentPage + 1;
    BlocProvider.of<MediaBloc>(context, listen: false).fetchMoreMedia(
        _searchTitle.isNotEmpty ? _searchTitle : widget.queryString,
        widget.mediaType.inString.toUpperCase(),
        newPage.toString());
  }
}

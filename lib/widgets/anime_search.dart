import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanime_info/bloc/media/media_bloc.dart';
import 'package:myanime_info/repositories/media_repository.dart';
import 'package:myanime_info/widgets/media_list.dart';
import 'package:myanime_info/widgets/switch_type.dart';

class AnimeSearch extends StatelessWidget {
  final TextEditingController _textEditingController =
      new TextEditingController();
  MediaType _searchingMediaType = MediaType.Anime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediaBloc>(
      create: (context) => MediaBloc(
          mediaRepository: RepositoryProvider.of<MediaRepository>(context)),
      child: Column(
        children: [
          _searchBox(context),
          Expanded(
            child: MediaList(
              key: UniqueKey(),
              queryString: _textEditingController.text,
              mediaType: _searchingMediaType,
              searchType: SearchType.MEDIA_SEARCH,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox(BuildContext context) {
    return BlocBuilder<MediaBloc, MediaState>(
        builder: (BuildContext ctx, MediaState state) {
          print(_textEditingController.text);
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 4.0,
            child: Column(
              children: [
                ListTile(
                  title: TextField(
                    controller: _textEditingController,
                    onSubmitted: (title) async {
                      if (title != null && title.isNotEmpty) {
                        bool hasConnection =
                            await DataConnectionChecker().hasConnection;
                        if (hasConnection) {
                          BlocProvider.of<MediaBloc>(ctx, listen: false)
                              .searchMedia(
                            title,
                            _searchingMediaType.inString.toUpperCase(),
                            "1",
                          );
                        } else {
                          Scaffold.of(ctx).showSnackBar(SnackBar(
                            content: Text("Check internet connectivity"),
                          ));
                        }
                      } else
                        Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Text("Title not valid"),
                        ));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Divider(),
                SwitchType(
                  onSwitchChange: (MediaType searchingMediaType) =>
                      _searchingMediaType = searchingMediaType,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

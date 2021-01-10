import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanime_info/bloc/media/media_bloc.dart';

class SwitchType extends StatefulWidget {
  SwitchType({Key key, this.onSwitchChange}) : super(key: key);

  final Function(MediaType _searchingMediaType) onSwitchChange;

  @override
  _SwitchTypeState createState() => _SwitchTypeState();
}

class _SwitchTypeState extends State<SwitchType> {
  String _switchText = MediaType.Anime.inString;
  bool _isSearchingAnime = false;
  MediaType _searchingMediaType = MediaType.Anime;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(_switchText),
      value: _isSearchingAnime,
      onChanged: (value) {
        if (value) {
          setState(() {
            _switchText = MediaType.Manga.inString;
            _searchingMediaType = MediaType.Manga;
          });
        } else {
          setState(() {
            _switchText = MediaType.Anime.inString;
            _searchingMediaType = MediaType.Anime;
          });
        }
        _isSearchingAnime = value;
        widget.onSwitchChange(_searchingMediaType);
        BlocProvider.of<MediaBloc>(context, listen: false).switchTypeMedia();
      },
      secondary: Icon(Icons.filter_list_alt),
    );
  }
}

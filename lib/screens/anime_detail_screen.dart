import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:myanime_info/bloc/media/media_bloc.dart';
import 'package:myanime_info/models/media.dart';
import 'package:myanime_info/utils/constants.dart';
import 'package:myanime_info/utils/detail_argument.dart';
import 'package:myanime_info/widgets/listview_media_info.dart';
import 'package:myanime_info/widgets/media_info.dart';

class AnimeDetailScreen extends StatelessWidget {
  static const String routeName = "/anime-detail";

  AnimeDetailScreen({Key key}) : super(key: key);
  MediaType _mediaType;

  Widget build(BuildContext context) {
    MediaDetailScreenArgument arguments =
        ModalRoute.of(context).settings.arguments as MediaDetailScreenArgument;
    _mediaType = arguments.type;
    Media media = arguments.media;
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => FadeInAnimation(
                  child: widget,
              ),
              children: [
                _topContent(context, media),
                _bottomContent(context, media)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topContent(BuildContext context, Media anime) {
    return Stack(
      children: <Widget>[
        anime.coverImage != null ? Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(anime.coverImage),
              fit: BoxFit.cover,
            ),
          ),
        ) : Container(),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: _topContentText(anime),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _topContentText(Media anime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100.0),
        Icon(
          _mediaType == MediaType.Anime ? Icons.slideshow : Icons.book,
          color: Colors.white,
          size: 20.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        FittedBox(
          child: Text(
            anime.title ?? Constants.NOT_AVAILABLE,
            style: TextStyle(
              color: Colors.white,
              fontSize: 45.0,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      anime.type ?? Constants.NOT_AVAILABLE,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(7.0),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0)),
                child: FittedBox(
                  child: new Text(
                    "${anime.status ?? Constants.NOT_AVAILABLE}",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _bottomContent(BuildContext context, Media media) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Html(
              data: media.description ?? Constants.NOT_AVAILABLE,
            ),
          ),
        ),
        _mediaType == MediaType.Anime
            ? MediaInfo(
                text: "Episodes: ${media.nEpisodes ?? Constants.NOT_AVAILABLE}",
                icon: Icons.format_list_numbered,
              )
            : MediaInfo(
                text: "Volumes: ${media.volumes ?? Constants.NOT_AVAILABLE}",
                icon: Icons.list,
              ),
        _mediaType == MediaType.Anime
            ? MediaInfo(
                text:
                    "Duration: ${media.duration ?? Constants.NOT_AVAILABLE} min",
                icon: Icons.access_time,
              )
            : MediaInfo(
                text: "Chapters: ${media.volumes ?? Constants.NOT_AVAILABLE}",
                icon: Icons.list,
              ),
        MediaInfo(
          text: "Started: ${media.startDate ?? Constants.NOT_AVAILABLE}",
          icon: Icons.date_range,
        ),
        MediaInfo(
          text: "Ended: ${media.endDate ?? Constants.NOT_AVAILABLE}",
          icon: Icons.date_range,
        ),
        MediaInfo(
          text:
              "Average Score: ${media.averageScore != null ? media.averageScore.toString() + "/100" : Constants.NOT_AVAILABLE}",
          icon: Icons.score,
        ),
        MediaInfo(
          text: "Popularity: ${media.popularity ?? Constants.NOT_AVAILABLE}",
          icon: Icons.score,
        ),
        media.isAdult != null
            ? MediaInfo(
                text: "Adult ONLY",
                icon: media.isAdult ? Icons.check : Icons.clear,
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
        Text("Characters", style: TextStyle(fontSize: 18)),
        ListViewMediaInfo(mediaList: media.characters),
        SizedBox(
          height: 20,
        ),
        Text("Cast", style: TextStyle(fontSize: 18)),
        ListViewMediaInfo(mediaList: media.staff)
      ],
    );
  }
}

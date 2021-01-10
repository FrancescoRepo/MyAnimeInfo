import 'package:flutter/material.dart';

class MediaInfo extends StatelessWidget {
  MediaInfo({Key key, this.text, this.icon}) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new ListTile(
          title: new Text(
            text == null || text.isEmpty ? '//' : text,
            style: new TextStyle(
              color: Colors.blueGrey[400],
              fontSize: 14.0,
            ),
          ),
          leading: new Icon(
            icon,
            color: Colors.blue[400],
          ),
        ),
        new Container(
          height: 0.3,
          color: Colors.blueGrey[400],
        )
      ],
    );
  }
}

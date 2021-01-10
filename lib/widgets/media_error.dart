import 'package:flutter/material.dart';

class MediaErrorWidget extends StatelessWidget {
  MediaErrorWidget({Key key, this.message}) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/img/error.png"),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

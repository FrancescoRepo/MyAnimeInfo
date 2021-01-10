import 'package:flutter/material.dart';

class ListViewMediaInfo extends StatelessWidget {
  ListViewMediaInfo({Key key, this.mediaList}) : super(key: key);

  final List<dynamic> mediaList;

  @override
  Widget build(BuildContext context) {
    if (mediaList.length > 0) {
      final names = mediaList.map((e) => e.name).toSet();
      mediaList.retainWhere((x) => names.remove(x.name));
      return SizedBox(
        height: 130,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: mediaList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = mediaList[index];
            return SizedBox(
              width: 100,
              child: Card(
                semanticContainer: true,
                elevation: 5.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(item.image).image,
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.luminosity),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("[No data found]"),
      ),
    );
  }
}

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:myanime_info/bloc/category/category_bloc.dart';
import 'package:myanime_info/models/category.dart';
import 'package:myanime_info/repositories/category_repository.dart';
import 'package:myanime_info/screens/media_list_screen.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc(
          categoryRepository:
              RepositoryProvider.of<CategoryRepository>(context))
        ..fetchCategories(),
      lazy: false,
      child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (BuildContext ctx, CategoryState state) {
        if (state is FetchedCategoryState) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final item = state.categories[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _cardItem(context, item),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]);
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget _cardItem(BuildContext context, Category item) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: _makeListTile(context, item),
      ),
    );
  }

  Widget _makeListTile(BuildContext context, Category item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
            right: new BorderSide(width: 1.0, color: Colors.white24),
          ),
        ),
        child: Icon(
          Icons.list,
          color: Colors.white,
          size: 40,
        ),
      ),
      title: Text(
        item.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(Icons.info_outline, color: Colors.yellowAccent),
          Text(" Click for more info", style: TextStyle(color: Colors.white))
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () async {
        bool hasConnection = await DataConnectionChecker().hasConnection;
        if (hasConnection) {
          Navigator.of(context)
              .pushNamed(MediaListScreen.routeName, arguments: item.name);
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Please check internet connectivity")));
        }
      },
    );
  }
}

import 'package:baobab_app/blocs/local/story_home.bloc.dart';
import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/models.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';

class BackToIndex extends StatelessWidget {
  final StoryHomeBLoC bloc;

  const BackToIndex({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: PreferredStreamBuilder<PageChange>(
        stream: bloc.pageChange.stream.where((pageChange) => !pageChange.triggeredByBack),
        initialData: PageChange(0),
        showLoading: false,
        builder: (data) {
          print("data" + data.page.toString());
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            transform: Matrix4.translationValues(
              data.page > 0 ? 0.0 : -100.0,
              0.0,
              0.0,
            ),
            child: IconButton(
              icon: Icon(Drawable.back1, color: Colors.grey),
              onPressed: () {
                bloc.pageChange.add(PageChange(0, triggeredByBack: true));
              },
            ),
          );
        },
      ),
    );
  }
}




import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/models.dart';

class StoryHomeBLoC extends LocalBLoC {


  @override
  List<BaseIO> get ioList => [pageChange];


  final pageChange = IO<PageChange>(isBehavior: true);


}
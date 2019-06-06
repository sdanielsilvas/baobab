import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/models.dart';

class StoryDetailBLoC extends LocalBLoC {


  final showMoreOperate = IO<bool>(seedValue: false, isBehavior: true);

  StoryDetailBLoC() : super('Story details BLoC');

  Story data;

  @override
  // TODO: implement ioList
  List<BaseIO> get ioList => [showMoreOperate];


}
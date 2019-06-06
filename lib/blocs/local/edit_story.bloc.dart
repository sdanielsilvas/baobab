
import 'package:baobab_app/helper/helper.export.dart';

class EditStoryBloc extends LocalBLoC {


  EditStoryBloc() : super('Story edit BLoC');


  @override
  // TODO: implement ioList
  List<BaseIO> get ioList => [scrollPage];

  /// letsDoIt
  final scrollPage = IO<int>(seedValue: 0);

  /// how was your day
  final howWasYourDay = IO<double>(seedValue: 0.0);

  final whatMadeToday = IO<String>(seedValue: '');

}
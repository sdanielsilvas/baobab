part of '../helper.export.dart';

abstract class BLoC {

  String semantics;

  BLoC([this.semantics]);

  void reassemble() {}


  @mustCallSuper
  void close() {
    print('=============================================\n'
        '${semantics ??= runtimeType.toString()} closed '
        '\n=============================================');
  }

}



abstract class RootBLoC extends BLoC {
  RootBLoC([String semantics]) : super(semantics);

  List<GlobalBLoC> get globalBLoCList;

  @override
  void close() {
    globalBLoCList?.forEach((bloc) => bloc.close());

    super.close();
  }
}

abstract class LocalBLoC extends BLoC {
  LocalBLoC([String semantics]) : super(semantics);

  /// All event collections are mainly provided to RuntimeScaffold
  List<BaseIO> get ioList;

  @override
  void close() {
    ioList?.forEach((event) => event.dispose());

    super.close();
  }
}

abstract class GlobalBLoC extends BLoC {
  GlobalBLoC([String semantics]) : super(semantics);

  /// All event collections are mainly provided to RuntimeScaffold
  List<BaseIO> get ioList;

  @override
  void close() {
    ioList?.forEach((event) => event.dispose());

    super.close();
  }
}
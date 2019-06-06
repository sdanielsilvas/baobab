part of '../helper.export.dart';

typedef void _Init<T extends BLoC>(T bloc);

class BLoCProvider<T extends BLoC> extends StatefulWidget {
  static PageAnalytics analytics;

  final T bloc;
  final _Init<T> init;
  final Widget child;
  final bool withAnalytics;

  static Type _typeOf<T>() => T;

  BLoCProvider({this.child, this.bloc, this.init, this.withAnalytics = true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BLoCProviderState();
  }


  static T of<T extends BLoC>(BuildContext context) {
    final type = _typeOf<BLoCProvider<T>>();
    BLoCProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }


}


class _BLoCProviderState<T extends BLoC> extends State<BLoCProvider<T>> {


  @override
  void initState() {
    super.initState();
    if (isNotEmpty(widget.init)) widget.init(widget.bloc);

    if (BLoCProvider.analytics != null && widget.withAnalytics) {
      print('${T.toString()} start');
      BLoCProvider.analytics.onPageStart(T.toString());
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void reassemble() {
    widget.bloc.reassemble();
    super.reassemble();
  }


  @override
  void dispose() {
    if (BLoCProvider.analytics != null && widget.withAnalytics) {
      BLoCProvider.analytics.onPageEnd(T.toString());
      print('${T.toString()} end');
    }
    widget.bloc.close();
    super.dispose();
  }
}
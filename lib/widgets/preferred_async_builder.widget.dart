import 'package:baobab_app/utils/empty_util.dart';
import 'package:baobab_app/widgets/empty_placeholder.widget.dart';
import 'package:baobab_app/widgets/error_placeholder.widget.dart';
import 'package:baobab_app/widgets/loading.widget.dart';
import 'package:flutter/material.dart';

typedef Widget _Builder<DATA>(DATA data);
typedef Widget _ErrorPlaceholderBuilder(BuildContext context, Object error);

class PreferredFutureBuilder<T> extends StatelessWidget {
  static Widget defaultEmptyPlaceholder;
  static Widget defaultErrorPlaceholder;

  static void setDefaultPlaceholder({
    Widget emptyPlaceholder,
    Widget errorPlaceholder,
  }) {
    defaultEmptyPlaceholder = emptyPlaceholder;
    defaultErrorPlaceholder = errorPlaceholder;
  }

  const PreferredFutureBuilder({
    Key key,
    @required this.future,
    @required this.builder,
    this.showLoading = true,
    this.initialData,
    this.emptyPlaceholder,
    this.errorPlaceholderBuilder,
  }) : super(key: key);

  final Future<T> future;
  final _Builder<T> builder;
  final bool showLoading;
  final T initialData;
  final Widget emptyPlaceholder;
  final _ErrorPlaceholderBuilder errorPlaceholderBuilder;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<T>(
      initialData: initialData,
      future: future,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          if (errorPlaceholderBuilder != null) {
            return errorPlaceholderBuilder(context, snapshot.error);
          } else {
            return defaultErrorPlaceholder ?? const ErrorPlaceholder();
          }
        }

        if (snapshot.hasData) {
          if (isEmpty(snapshot.data)) {
            return emptyPlaceholder ?? defaultEmptyPlaceholder ?? const EmptyPlaceholder();
          } else {
            return builder(snapshot.data);
          }
        } else if (showLoading) {
          return LoadingWidget();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class PreferredStreamBuilder<T> extends StatelessWidget {
  static Widget defaultEmptyPlaceholder;
  static Widget defaultErrorPlaceholder;

  static void setDefaultPlaceholder({
    Widget emptyPlaceholder,
    Widget errorPlaceholder,
  }) {
    defaultEmptyPlaceholder = emptyPlaceholder;
    defaultErrorPlaceholder = errorPlaceholder;
  }

  const PreferredStreamBuilder({
    Key key,
    @required this.stream,
    @required this.builder,
    this.showLoading = true,
    this.initialData,
    this.emptyPlaceholder,
    this.errorPlaceholderBuilder,
  }) : super(key: key);

  final Stream<T> stream;
  final _Builder<T> builder;
  final bool showLoading;
  final T initialData;
  final Widget emptyPlaceholder;
  final _ErrorPlaceholderBuilder errorPlaceholderBuilder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initialData,
      stream: stream,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          if (errorPlaceholderBuilder != null) {
            return errorPlaceholderBuilder(context, snapshot.error);
          } else {
            return defaultErrorPlaceholder ?? const ErrorPlaceholder();
          }
        }

        if (snapshot.hasData) {
          if (isEmpty(snapshot.data)) {
            return emptyPlaceholder ??
                defaultEmptyPlaceholder ??
                const EmptyPlaceholder();
          } else {
            return builder(snapshot.data);
          }
        } else if (showLoading) {
          return LoadingWidget();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
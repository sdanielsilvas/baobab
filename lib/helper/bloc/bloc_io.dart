part of '../helper.export.dart';




typedef bool _Equal<T>(T data1, T data2);
typedef Future<T> _Trigger<T>();

abstract class BaseIO<T> {
  BaseIO({
    this.seedValue,
    this.semantics,
    bool sync = true,
    bool isBehavior = false,
  }){
    subject = isBehavior
        ? BehaviorSubject<T>(seedValue: seedValue, sync: sync)
        : PublishSubject<T>(sync: sync);



    subject.listen((data) {
      latest = data;
      print('semantic ${semantics ??= data.runtimeType.toString()} latest: $latest'
          '\n+++++++++++++++++++++++++++END+++++++++++++++++++++++++++++');
    });
    latest = seedValue;
  }

  T latest;

  @protected
  T seedValue;

  @protected
  String semantics;

  /// Internal relay object
  @protected
  Subject<T> subject;


  void addError(Object error, [StackTrace stackTrace]) {
    subject.addError(error, stackTrace);
  }

  Observable<S> map<S>(S convert(T event)) {
    return subject.map(convert);
  }

  Observable<T> where(bool test(T event)) {
    return subject.where(test);
  }



  void clear() {
    print('-----------------------------BEGIN---------------------------------\n'
        '${semantics ??= runtimeType.toString()}event cleared '
        '\n------------------------------END----------------------------------');
    latest = seedValue;
    subject.add(seedValue);
  }

  /// 关闭流
  void dispose() {
   print('=============================BEGIN===============================\n'
        '${semantics ??= runtimeType.toString()}event disposed '
        '\n==============================END================================');
    subject.close();
  }

  @override
  String toString() {
    return 'Output{latest: $latest, seedValue: $seedValue, semantics: $semantics, subject: $subject}';
  }


}


class Input<T> extends BaseIO<T> with InputMixin {
  Input({
    T seedValue,
    String semantics,
    bool sync = true,
    bool isBehavior = false,
    bool acceptEmpty = false,
    bool isDistinct = true,
    _Equal test,
  }) : super(
    seedValue: seedValue,
    semantics: semantics,
    sync: sync,
    isBehavior: isBehavior,
  ) {
    this._acceptEmpty = acceptEmpty;
    this._isDistinct = isDistinct;
    this._test = test;
  }
}


class Output<T> extends BaseIO<T> with OutputMixin {
  Output({
    T seedValue,
    String semantics,
    bool sync = true,
    bool isBehavior = false,
    @required _Trigger<T> trigger,
  }) : super(
    seedValue: seedValue,
    semantics: semantics,
    sync: sync,
    isBehavior: isBehavior,
  ) {
    stream = subject.stream;
    _trigger = trigger;
  }
}


//Events that can be input and output
class IO<T> extends BaseIO<T> with InputMixin, OutputMixin {
  IO({
    T seedValue,
    String semantics,
    bool sync = true,
    bool isBehavior = false,
    bool acceptEmpty = false,
    bool isDistinct = true,
    _Equal test,
    _Trigger<T> trigger,
  }) : super(
    seedValue: seedValue,
    semantics: semantics,
    sync: sync,
    isBehavior: isBehavior,
  ) {
    stream = subject.stream;

    _acceptEmpty = acceptEmpty;
    _isDistinct = isDistinct;
    _test = test;
    _trigger = trigger;
  }
}


mixin InputMixin<T> on BaseIO<T> {
  bool _acceptEmpty;
  bool _isDistinct;
  _Equal _test;

  void add(T data) {
    print('+++++++++++++++++++++++++++BEGIN+++++++++++++++++++++++++++++\n'
        'IO received**${semantics ??= data.runtimeType.toString()}**data: $data');

    if (isEmpty(data) && !_acceptEmpty) {
      print('Forwarding is rejected! Cause: A non-Empty value is required, but an Empty value is received.');
      return;
    }
    // If you need distinct, judge whether it is the same; if you don't need distinct, directly transmit
    // the data pty value
    if (_isDistinct) {
      if (_test != null) {
        if (!_test(latest, data)) {
          print('IO forwards out **${semantics ??= data.runtimeType.toString()}** data: $data');
          subject.add(data);
        } else {
          print('Forwarding is rejected! Reason: Need to be unique, but not passed the uniqueness test');
        }
      } else {
        print('O forwards out **${semantics ??= data.runtimeType.toString()}** data: $data ');
        if (data != latest) {
          subject.add(data);
        } else {
          print('Forwarding is rejected! Reason: Need to be unique, but the new data is the same as the latest value');
        }
      }
    } else {
      print('IO forwarded out${semantics ??= data.runtimeType.toString()}**data: $data');

      subject.add(data);
    }

    //If you need distinct, judge whether it is the same; if you do not need distinct, directly transmit data
  }

  // If the latest value is _seedValue or is empty, then add new data, in other words, if the event has been added
  // If it is, then it will not be added, for the first time add
  void addIfAbsent(T data) {
    if (seedValue == latest || isEmpty(latest)) {
      add(data);
    }
  }
}

mixin OutputMixin<T> on BaseIO<T> {
  /// Output Future
  Future<T> get future => stream.first;

  // Output Stream
  Observable<T> stream;

  void listen(
    ValueChanged<T> listener, {
    Function onError,
    VoidCallback onDone,
    bool cancelOnError,
  }) {
    stream.listen(
      listener,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  /// flujo de salida
  _Trigger<T> _trigger;

  /// obtener datos utilizando disparador interno
  Future<T> update() {
    return _trigger()
      ..then(subject.add)
      ..catchError(subject.addError);
  }
}

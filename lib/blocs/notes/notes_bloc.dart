import 'package:baobab_app/database/database.dart';
import 'package:baobab_app/models/notes.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  String collectionNote = "notes";

  NotesBloc() {
    _getNotes();
  }

  final BehaviorSubject<List<Note>> _behaviorNotesSubject =
      new BehaviorSubject<List<Note>>();

  Sink<List<Note>> get _sinkPlayList => _behaviorNotesSubject.sink;

  Stream<List<Note>> get streamPlayList => _behaviorNotesSubject.stream;

  _getNotes() {
    try {
      Database.readDocumentsAtCollectionWithLimitByTimestampDescending(
              collectionNote, 100)
          .then((item) {
        _sinkPlayList.add(item.map((data) => Note.fromJson(data)).toList());
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    _behaviorNotesSubject.close();
  }
}

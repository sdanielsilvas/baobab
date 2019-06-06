import 'package:baobab_app/blocs/notes/notes_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:baobab_app/models/notes.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  List<Note> noteList;
  int count = 0;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    updateListView();
    if (noteList == null) {
      noteList = List<Note>();
       updateListView();
    }

    return Container(

      height: 200,
      color: Colors.white,
      child: getNotesList(),
    );
  }

  void updateListView() {
    this.noteList = noteList;

    NotesBloc notesBloc = new NotesBloc();

    notesBloc.streamPlayList.listen((item){
      setState(() {
        this.noteList = item;
        this.count = item.length;
      });
    });


    /*final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });*/
  }

  Widget getNotesList() {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent[100],
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              this.noteList[index].title,
                              style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        Text(
                          getPriorityText(this.noteList[index].priority),
                          style: TextStyle(
                              color: getPriorityColor(
                                  this.noteList[index].priority)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                this.noteList[index].description == null
                                    ? ''
                                    : this.noteList[index].description,
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 10)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }

  // Returns the priority icon
  String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
        break;
      case 2:
        return '!!';
        break;
      case 3:
        return '!';
        break;

      default:
        return '!!!';
    }
  }
}

import 'dart:async';

import 'package:baobab_app/blocs/authentication.dart';
import 'package:baobab_app/blocs/timeline/time_bloc.dart';
import 'package:baobab_app/blocs/timeline/time_line_bloc.dart';
import 'package:baobab_app/models/time_line_app.dart';
import 'package:baobab_app/pages/auth/login_page_bao.dart';
import 'package:baobab_app/pages/intro/intro_screen.dart';
import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContainerPage extends StatefulWidget {
  final List<TimeLineApp> timeLineApp;

  HomeContainerPage({this.timeLineApp});

  @override
  State<StatefulWidget> createState() {
    return _HomeContainerPageState();
  }
}

enum MenuOption {
  open,
  share,
  delete,
  edit,
  report,
  logout,
  login,
  myLinks,
  appInfo
}

class _HomeContainerPageState extends State<HomeContainerPage> {
  //final List<TimeLine> _planets ;
  int _currentPlanetIndex = 0;
  bool openedState = false;

  final StreamController _navigationStreamCntrllr =
  StreamController.broadcast();
  AuthenticationBloc
  authBloc; //=  BlocProvider.of<AuthenticationBloc>(context) ;
  static final String isOpened = "isOpened";

  //final authBloc  = BlocProvider.of<AuthenticationBloc>(context);

  @override
  initState() {
    super.initState();
    getIsOpen();
  }

  Future<bool> getIsOpen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    openedState = prefs.getBool(isOpened) ?? false;
    if (openedState == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
    print(openedState);
    return openedState;
  }

  dispose() {
    _navigationStreamCntrllr.close();
    super.dispose();
  }

  _handleArrowClick(ClickDirection direction) {
    setState(() {
      switch (direction) {
        case ClickDirection.Left:
          _currentPlanetIndex--;
          break;
        case ClickDirection.Right:
          _currentPlanetIndex++;
          break;
      }
    });
  }

  _buildMessageSection() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Text(
      "Estas seguro de que deseas salir ?",
      style: TextStyle(fontSize: 16.0),
    ),
  );

  _showConfirmmationDialog() async => showDialog(
      context: context,
      builder: (_) => new SimpleDialog(
          title: Text("Salir"),
          children: <Widget>[_buildMessageSection(), _buildActions()]));

  _buildActions() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: <Widget>[
        FlatButton(
          child: Text(
            "Confirmar",
            style: TextStyle(color: Colors.deepOrange),
          ),
          onPressed: () => _handleLogout(),
        ),
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );

  _handleLogout() async {
    //final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    Navigator.pop(context);
    authBloc.onLogout();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPageBao()));
    print("logout");
  }

  _handleSelectionMenuOption(MenuOption option) {
    switch (option) {
      case MenuOption.appInfo:
      // _showInfoDialog();
        break;
      case MenuOption.logout:
        _showConfirmmationDialog();
        break;
      case MenuOption.login:
      // _showLoginDialog(Intent.login);
        break;
      default:
        print('unexpected option $option');
    }
  }

  Widget _buildPopup() {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);

    Widget _morePopUpButton =
    //  ScopedModelDescendant<MainModel>(builder: (_, __, model) {
    PopupMenuButton<MenuOption>(
        icon: new Icon(Icons.more_horiz, color: Colors.black),
        onSelected: (option) => _handleSelectionMenuOption(option),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            value: MenuOption.appInfo,
            child: Text("Configuracion"),
          ),
          PopupMenuItem(
            value: MenuOption.logout,
            child: Text("Salir"),
          )
        ]);
    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: authBloc,
        builder: (BuildContext context, AuthenticationState authState) {
          return _morePopUpButton;
        });

    // });
  }

  @override
  Widget build(BuildContext context) {
    // print(_planets.length);
    final Size screenSize = MediaQuery.of(context).size;

    TimeLineBloc timeLineBloc = TimeLineBloc();

    TimeLineAppBLoc _timeLineAppBLoc = TimeLineAppBLoc();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          StreamBuilder<List<TimeLineApp>>(
              stream: _timeLineAppBLoc.timeLineStream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.data != null) {
                  print(snap.data);
                  return Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding:
                          EdgeInsets.only(top: screenSize.height * 0.14),
                          child: FractionalTranslation(
                            translation: Offset(0.0, 0.65),
                            child: TimeLineSelector(
                              screenSize: screenSize,
                              timeLines: snap.data,
                              currentPlanetIndex: _currentPlanetIndex,
                              onArrowClick: _handleArrowClick,
                              onPlanetClicked: () =>
                                  _navigationStreamCntrllr.sink.add(null),
                            ),
                          )),
                    ),
                    Container(
                      height: screenSize.height * 0.65,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Container(
                                width: 400.0,
                                padding: EdgeInsets.only(left: 50.0),
                                child: TimeLineName(
                                  name: snap.data[_currentPlanetIndex].name
                                      .toUpperCase(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                          EdgeInsets.only(top: screenSize.height * 0.33),
                          child: PersonWidget(
                            size: screenSize,
                            timeLines: snap.data,
                            currentPlanetIndex: _currentPlanetIndex,
                            shouldNavigate: _navigationStreamCntrllr.stream,
                          ),
                        )),
                    new Positioned(
                      //Place it at the top, and not use the entire screen
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: AppBar(
                        //  title: Text(widget.currentTimeLine.name),
                        textTheme: TextTheme(
                          title: TextStyle(
                              fontSize: 36.0, fontStyle: FontStyle.italic),
                        ),
                        backgroundColor: Colors.transparent,
                        //No more green
                        elevation: 0.0,
                        //Shadow gone
                        actions: <Widget>[
                          _buildPopup(),
                        ],
                      ),
                    ),
                  ]);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ]));
  }
}

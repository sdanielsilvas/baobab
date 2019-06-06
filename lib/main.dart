import 'dart:developer';

import 'package:baobab_app/blocs/authentication.dart';
import 'package:baobab_app/pages/auth.dart';
import 'package:baobab_app/pages/home_container/home_container.dart';
import 'package:baobab_app/pages/splash/video_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'database/repository.dart';

void main() {
  AuthenticationBloc authBloc = AuthenticationBloc();
  runApp(new MyApp(authBloc));
}

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final AuthenticationBloc authBloc;

  MyApp(this.authBloc);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.se

    return BlocProvider(
      // The BlocProvider, provides my authentication bloc to all children of this build context so that they
      // can inherit it and use it in their own methods
      bloc: authBloc,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        //theme: _createTheme(),
        /*supportedLocales: [
          const Locale('en', ''), // Inlés
          const Locale('es', ''), // Español
          const Locale('ca', 'CA'), // Catalán
        ],*/
        title: 'snacc',
        home: _rootPage(),
      ),
    );
  }

  Widget _rootPage() {
    log('data:hola mundo');



    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
      bloc: authBloc,
      builder: (BuildContext context, AuthenticationState authState) {
        List<Widget> _widgets = [];
        // print(authState.isAuthenticated);
        // print(authState.isInitialising);
        // print(authState.isLoading);

        if (authState.isAuthenticated) {
          print("is Atuenticate to app");

          _widgets.add(HomeContainerPage());

        } else {
          _widgets.add(LoginPageBao());
        }

        if (authState.isInitialising) {
          _widgets.add(VideoSplashScreen());
          // authBloc.onAutoLogin();
        }

        if (authState.isLoading) {
          _widgets.add(_loadingIndicator());
        }

        // A stack does what it says on the tin, stacks widgets (or in my case entire pages) on top of eachother.
        return Stack(
          children: _widgets,
        );
      },
    );
  }

  ThemeData _createTheme() {
    return ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Color(0xFFFEAA2B),
        accentColor: Color(0xFF2b7cb6),
        //Color(0xFFe1e6e1),
        cursorColor: Color(0xFF2274a5),
        primaryColorDark: Color(0xFF0d0106),
        primaryIconTheme: IconThemeData(color: Colors.cyan),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Color(0xff6869a9),
          disabledActiveTrackColor: Colors.red,
          disabledInactiveTrackColor: Colors.red,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
          disabledActiveTickMarkColor: Colors.red,
          disabledInactiveTickMarkColor: Colors.red,
          thumbColor: Colors.white,
          disabledThumbColor: Colors.white,
          overlayColor: Colors.white.withOpacity(0.3),
          valueIndicatorColor: Colors.blue,
          thumbShape: RoundSliderThumbShape(),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          showValueIndicator: ShowValueIndicator.never,
          valueIndicatorTextStyle: TextStyle(),
        )

    );
  }

  Widget _loadingIndicator() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:baobab_app/blocs/authentication.dart';
import 'package:baobab_app/style/theme.dart' as Theme;
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoSplashScreenState();
}

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

Future<bool> isIOSSimulator() async {
  return Platform.isIOS && !(await deviceInfoPlugin.iosInfo).isPhysicalDevice;
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  final Completer<void> connectedCompleter = Completer<void>();
  bool isSupported = true;

  bool errorShown = true;

  bool infoShown = true;

  final VideoPlayerController logoController = VideoPlayerController.asset(
    'assets/videos/aeologic_logo.mp4',
  );

  AuthenticationBloc authBloc;

  @override
  void initState() {
    super.initState();

    Future<void> initController(VideoPlayerController controller) async {
      controller.setLooping(true);
      controller.setVolume(0.0);
      controller.play();
      await connectedCompleter.future;
      await controller.initialize();
      if (mounted) setState(() {});
    }

    startTime();
    initController(logoController);
    isIOSSimulator().then<void>((bool result) {
      isSupported = !result;
    });
  }

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocBuilder(
        bloc: authBloc,
        builder: (BuildContext context, AuthenticationState authState) {
          if (authState.error != '' && !errorShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Scaffold.of(context).showSnackBar(errorSnackBar(authState.error));
              errorShown = true;
            });
          }

          if (authState.info != '' && !infoShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Scaffold.of(context).showSnackBar(errorSnackBar(authState.info));
              infoShown = true;
            });
          }

          return Stack(overflow: Overflow.visible, fit: StackFit.expand, children: <Widget>[
            Positioned(
              child: Hero(
                tag: 'splash',
                child: SplashBodyWidget(imagePath: 'assets/splash_logo.gif'),
              ),
            ),
          ]);

          return Scaffold(
              body: isSupported
                  ? Stack(fit: StackFit.expand, children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: new Color(0xff622f74),
                          gradient: LinearGradient(
                            colors: [new Color(0xff0F2027), new Color(0xff203A43)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ])
                  : const Center(
                      child: Text(
                        'Video playback not supported on the iOS Simulator.',
                      ),
                    ));
        });
  }

  startTime() async {
    var _duration = new Duration(seconds: 8);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    print("autologin");
    authBloc.onAutoLogin();
  }

  @override
  void dispose() {
    super.dispose();
    logoController.dispose();
  }
}

class SplashBodyWidget extends StatelessWidget {
  final String imagePath;

  SplashBodyWidget({this.imagePath});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height >= 775.0 ? MediaQuery.of(context).size.height : 775.0,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Theme.Colors.loginGradientEnd, Theme.Colors.loginGradientStart],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
/*
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
           // Colors.transparent,
            Theme.Colors.loginGradientStart,
            Theme.Colors.loginGradientEnd,
           // Colors.black.withOpacity(0.065),
         //   Colors.black87,
       //     Colors.black
          ],
        ),
      ),*/
    );
  }
}

import 'package:baobab_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:baobab_app/style/theme.dart' as Theme;

class MenuBarLogin extends StatelessWidget {
  final Function onSignInButtonPress;
  final Function onSignUpButtonPress;
  final PageController pageController;
  final Color left;
  final Color right ;

  MenuBarLogin({
    @required this.onSignInButtonPress,
    @required this.onSignUpButtonPress,
    @required this.pageController,
    @required this.left,
    @required this.right,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color:  Theme.Colors.loginGradientStart,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: onSignInButtonPress,
                child: Text(
                  "Existente!",
                  style: TextStyle(color: left, fontSize: 16.0, fontFamily: "OpenSans"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: onSignUpButtonPress,
                child: Text(
                  "Nuevo!",
                  style: TextStyle(color: right, fontSize: 16.0, fontFamily: "OpenSans"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

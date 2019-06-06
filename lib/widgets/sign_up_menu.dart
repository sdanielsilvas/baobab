import 'package:baobab_app/blocs/authentication.dart';
import 'package:baobab_app/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpMenu extends StatelessWidget {
  final FocusNode myFocusNodeName;

  final FocusNode myFocusNodeEmail;

  final FocusNode myFocusNodePassword;

  final TextEditingController signupEmailController;

  final TextEditingController signupNameController;

  final TextEditingController signupPasswordController;

  final TextEditingController signupConfirmPasswordController;

  final Function showInSnackBar;

  final Function toggleSignupConfirm;

  final Function toggleSignup;

  final Function onSignupButtonPressed;

  final AuthenticationBloc authenticationBloc;

  bool _obscureTextSignup = true;

  bool _obscureTextSignupConfirm = true;

  String _datetime = 'tap date icon to edit';

  SignUpMenu(
      {@required this.myFocusNodeName,
      @required this.myFocusNodeEmail,
      @required this.myFocusNodePassword,
      @required this.signupEmailController,
      @required this.signupNameController,
      @required this.signupPasswordController,
      @required this.signupConfirmPasswordController,
      @required this.showInSnackBar,
      @required this.toggleSignupConfirm,
      @required this.toggleSignup,
      @required this.onSignupButtonPressed,
      @required this.authenticationBloc});

  @override
  Widget build(BuildContext context) {

    return Container(child: _buildMenu(),);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: viewportConstraints.maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildMenu()
            ],
          ),
        ));
      },
    );
  }

  Widget _buildMenu() {
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Card(
            elevation: 10.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: 300.0,
              height: 340.0,
              child: ListView(
                padding:  EdgeInsets.only(top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(fontFamily: "OpenSans", fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "Nombre",
                            hintStyle: TextStyle(fontFamily: "OpenSans", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontFamily: "OpenSans", fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: "Correo Electrónico",
                            hintStyle: TextStyle(fontFamily: "OpenSans", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(fontFamily: "OpenSans", fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "Contraseña",
                            hintStyle: TextStyle(fontFamily: "OpenSans", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: toggleSignup,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),

                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextSignupConfirm,
                          style: TextStyle(fontFamily: "OpenSans", fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "Confirmación",
                            hintStyle: TextStyle(fontFamily: "OpenSans", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: toggleSignupConfirm,
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            )),
        Container(
            margin: EdgeInsets.only(top: 330.0),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.Colors.loginGradientStart,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 5.0,
                ),
                BoxShadow(
                  color: Theme.Colors.loginGradientStart,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 5.0,
                ),
              ],
              gradient: new LinearGradient(
                  colors: [Theme.Colors.loginGradientStart, Theme.Colors.loginGradientStart],
                  begin: const FractionalOffset(0.2, 0.2),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: MaterialButton(
              // highlightColor: Colors.transparent,
              splashColor: Theme.Colors.loginGradientStart,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                child: Text(
                  "Registrarse",
                  style: TextStyle(color: Colors.white, fontSize: 22.0, fontFamily: "OpenSans"),
                ),
              ),
              onPressed: () => onSignupButtonPressed(authenticationBloc),
            )),
      ],
    );
  }
}

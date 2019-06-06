import 'package:baobab_app/blocs/authentication.dart';
import 'package:baobab_app/style/theme.dart' as Theme;
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/step/signup_screen_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBao extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageStateBao();
  }
}

class _LoginPageStateBao extends State<LoginPageBao> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController = new TextEditingController();
  TextEditingController _forgotPasswordTextEditingController = TextEditingController();

  PageController _pageController;

  AuthenticationBloc authBloc;

  Color left = Colors.black;
  Color right = Colors.white;

  bool errorShown = true;

  bool infoShown = true;

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocBuilder(
        bloc: authBloc,
        builder: (BuildContext context, AuthenticationState authState) {
          if (authState.error != '' && !errorShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scaffoldKey.currentState.showSnackBar(errorSnackBar(authState.error));
              errorShown = true;
            });
          }

          if (authState.info != '' && !infoShown) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scaffoldKey.currentState.showSnackBar(errorSnackBar(authState.info));
              infoShown = true;
            });
          }

          // TODO: implement build
          return new Scaffold(
            key: _scaffoldKey,
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height >= 775.0 ? MediaQuery.of(context).size.height : 775.0,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Theme.Colors.loginGradientEnd, Theme.Colors.loginGradientStart],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 75.0),
                        child: new Image(
                            width: 250.0,
                            height: 191.0,
                            fit: BoxFit.fill,
                            image: new AssetImage('assets/img/login_logo.png')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: MenuBarLogin(
                          onSignInButtonPress: _onSignInButtonPress,
                          onSignUpButtonPress: _onSignUpButtonPress,
                          pageController: _pageController,
                          left: left,
                          right: right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (i) {
                            if (i == 0) {
                              setState(() {
                                right = Colors.white;
                                left = Colors.black;
                              });
                            } else if (i == 1) {
                              setState(() {
                                right = Colors.black;
                                left = Colors.white;
                              });
                            }
                          },
                          children: <Widget>[
                            new ConstrainedBox(
                              constraints: const BoxConstraints.expand(),
                              child: _buildSignIn(authBloc),
                            ),
                            new ConstrainedBox(
                              constraints: const BoxConstraints.expand(),
                              child: _buildSignUp(authBloc),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "OpenSans"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  ////

  Widget _buildSignIn(AuthenticationBloc authBloc) {
    return SignInMenu(
      myFocusNodeEmailLogin: myFocusNodeEmailLogin,
      loginEmailController: loginEmailController,
      loginPasswordController: loginPasswordController,
      myFocusNodePasswordLogin: myFocusNodePasswordLogin,
      onLoginButtonPressed: _onLoginButtonPressed,
      onForgotPasswordButtonPressed: _onForgotPasswordButtonPressed,
      authenticationBloc: authBloc,
      obscureTextLogin: _obscureTextLogin,
      toggleLogin: _toggleLogin,
    );
  }

  Widget _buildSignUp(AuthenticationBloc authBloc) {
    return SignUpMenu(
      myFocusNodeName: myFocusNodeName,
      myFocusNodeEmail: myFocusNodeEmail,
      myFocusNodePassword: myFocusNodePassword,
      signupEmailController: signupEmailController,
      signupNameController: signupNameController,
      signupPasswordController: signupPasswordController,
      signupConfirmPasswordController: signupConfirmPasswordController,
      showInSnackBar: showInSnackBar,
      toggleSignupConfirm: _toggleSignupConfirm,
      toggleSignup: _toggleSignup,
      onSignupButtonPressed: _onSignupButtonPressed,
      authenticationBloc: authBloc,
    );
  }

  ////

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  _onForgotPasswordButtonPressed(BuildContext context, AuthenticationBloc authBloc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  NormalTextInput(
                    textEditingController: _forgotPasswordTextEditingController,
                    title: 'Recuperar Contraseña',
                    hintText: 'Ingresa tu correo electrónico...',
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: StandardFilledButton(
                        text: 'Recuperar Contraseña',
                        backgroundColor: Color(0xFF2b7cb6),
                        onPressed: () {
                          // _onForgotPasswordSendEmailButtonPressed(authBloc);
                          print("hola1" + authBloc.toString());
                          authBloc.onForgotPassword(email: _forgotPasswordTextEditingController.text);

                          setState(() {
                            errorShown = false;
                            infoShown = false;
                          });

                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ]);
        });
  }

  _onSignupButtonPressed(AuthenticationBloc authBloc) {
    print("create" + authBloc.toString());


   /* Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpStepScreen()));
*/
    authBloc.onSignup(
        fullName: signupNameController.text,
        email: signupEmailController.text,
        password: signupPasswordController.text,
        passwordRepeated: signupConfirmPasswordController.text);

    setState(() {
      errorShown = false;
      infoShown = false;
    });
  }

  _onLoginButtonPressed(AuthenticationBloc authBloc) {
    // Pass the entered details to the auth bloc which will then cause a LoginEvent to be dispatched
    authBloc.onLogin(email: loginEmailController.text, password: loginPasswordController.text);

    setState(() {
      errorShown = false;
      infoShown = false;
    });
  }

  SnackBar errorSnackBar(String error) {
    return SnackBar(
      content: Text(error),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}

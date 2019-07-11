import 'package:baobab_app/pages/home_container/home_container.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  static final String isOpened = "isOpened";
  bool openedState = false;

  //set whether screen has already shown
  Future<bool> setIsOpen(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isOpened, value);
  }

  Future<bool> getIsOpen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    openedState = prefs.getBool(isOpened);
    if (openedState == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeContainerPage()));
    }
    print(openedState);
    return openedState;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    slides.add(new Slide(
        title: "Pantall 1",
        description: "Introduccion 1",
        backgroundColor: Color(0xFF2b7cb6),
        backgroundOpacityColor: Colors.red));
    slides.add(new Slide(
      title: "Pantall 2",
      description: "Introduccion 2",
      backgroundColor: Color(0xFF2b7cb6),
    ));
    slides.add(new Slide(
      title: "Pantall 2",
      description: "Introduccion 3",
      backgroundColor: Color(0xFF2b7cb6),
    ));
  }

  void onDonePress() {
    setIsOpen(true);
    getIsOpen();
  }

  void onSkipPress() {
    setIsOpen(true);
    getIsOpen();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
      colorActiveDot: Colors.green,
      isShowDotIndicator: true,
      highlightColorDoneBtn: Colors.green,
      highlightColorSkipBtn: Colors.red,
    );
  }
}

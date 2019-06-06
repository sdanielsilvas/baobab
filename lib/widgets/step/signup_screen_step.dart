import 'dart:ui' as ui;

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'animation_box_widget.dart';
import 'last_page.dart';

class SignUpStepScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpStepScreen>
    with TickerProviderStateMixin {
  AnimationController _animateController;
  AnimationController _secondStepController;
  AnimationController _thirdStepController;
  AnimationController _fourStepController;

  Animation<double> secondTranformAnimation;
  Animation<double> thirdTranformAnimation;
  Animation<double> fourTranformAnimation;

  String overallStatus = "Good";

  int curIndex = 0;
  double overall = 3.0;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool enabledNext = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        vsync: this, duration: Duration(microseconds: 2000));
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFourStepAnimation() async {
    try {
      await _fourStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Center(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                            child: Text('Atras'),
                            //shape: OutlineInputBorder(),
                            onPressed: curIndex == 0 ? null : onPressedPrev),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: MaterialButton(
                            height: 50,
                            disabledElevation: 8,
                            highlightElevation: 2,
                            // shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            child: curIndex < 1 ? Text('Siguiente'):Text('Finalizar'),
                            onPressed: curIndex == 2 ? null : onPressedNext),
                      ),
                    ],
                  )),
                ),
              ),
            )
          : null,
    );
  }

  void onPressedNext() {
   // if (_fbKey.currentState.validate()) {
      setState(() {
        curIndex += 1;
        if (curIndex == 1) {
          _startSecondStepAnimation();
        } else if (curIndex == 2) {
          finish();
          //startThirdStepAnimation();
        } else if (curIndex == 3) {
         // finish();
        }
      });
  //  }
  }

  void onPressedPrev() {
    setState(() {
      curIndex -= 1;
      if (curIndex == 1) {
        _startSecondStepAnimation();
      } else if (curIndex == 2) {
        _startThirdStepAnimation();
      } else if (curIndex == 3) {
        _startFourStepAnimation();
      }
    });
  }

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0),
          height: 10.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(2, (int index) {
              return Container(
                decoration: BoxDecoration(
                  color: index <= curIndex ? Color(0xFF2b7cb6) : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 10.0,
                width: (_width - 32.0 - 15.0) / 2.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? _getFirstStep()
            : curIndex == 1
                ? _getSecondStep()
                : curIndex == 2 ? _getThirdStep() : _getFourStep(),
      ],
    );
  }

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 20),
                    child: FormBuilderDateTimePicker(
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      decoration:
                          InputDecoration(labelText: "Fecha de nacimiento"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 20),
                    child: FormBuilderDropdown(
                      attribute: "Sexo",
                      decoration: InputDecoration(labelText: "Genero"),
                      // initialValue: 'Male',
                      hint: Text('Selección de genero'),

                      items: ['Masculino', 'Femenino', 'Otro']
                          .map((gender) => DropdownMenuItem(
                              value: gender, child: Text("$gender")))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 20),
                    child: FormBuilderDateTimePicker(
                      attribute: "diagnostic_date",
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      decoration:
                          InputDecoration(labelText: "Fecha de diagnostico"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 40),
                      child: Text(
                        "Donde encuentras o creas espacios de calma y paz, cuando quieres paz interior",
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12, right: 20, top: 0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(labelText: ""),
                      attribute: "languages",
                      initialValue: ["Dart"],
                      options: [
                        FormBuilderFieldOption(value: "En la ciudad"),
                        FormBuilderFieldOption(value: "En la naturaleza"),
                        FormBuilderFieldOption(value: "Oración"),
                        FormBuilderFieldOption(value: "Meditación"),
                        FormBuilderFieldOption(value: "Yoga"),
                        FormBuilderFieldOption(value: "Otro"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getSecondStep() {
    return Expanded(
        child: Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 12, right: 20, top: 50),
              child: Column(
                children: <Widget>[
                  Text("Te sientes Activo en el proces de Sanacion ?"),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: ""),
                    attribute: "languages",
                    initialValue: [""],
                    options: [
                      FormBuilderFieldOption(value: "Si "),
                      FormBuilderFieldOption(value: "No"),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 12, right: 20, top: 50),
              child: Column(
                children: <Widget>[
                  Text(
                      "Crees que es importante participar en el proceso de sanacion ?"),
                  FormBuilderRadio(
                    decoration: InputDecoration(labelText: ""),
                    attribute: "languages",
                    initialValue: [""],
                    options: [
                      FormBuilderFieldOption(value: "Si "),
                      FormBuilderFieldOption(value: "No"),
                    ],
                  ),
                ],
              )),
          FormBuilderCheckbox(
            attribute: 'accept_terms',
            initialValue: false,
            // onChanged: _onChanged,
            leadingInput: true,
            label: Text("Aceptas los terminos y Condicionees?"),
            validators: [
              FormBuilderValidators.requiredTrue(
                errorText: "You must accept terms and conditions to continue",
              ),
            ],
          ),
        ],
      ),
    ));
  }


  void finish(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder:
                (BuildContext context) =>
                LastPage(
                  statusType: 'Unhappy',
                )));

  }

  Widget _getThirdStep() {
    return Expanded(child: Container(


    ));
  }

  Widget _getFourStep() {
    return Expanded(child: Container());
  }

  _getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        overallStatus = 'Bad';
        break;
      case 2:
        overallStatus = 'Normal';
        break;
      case 3:
        overallStatus = 'Good';
        break;
      case 4:
        overallStatus = 'Very Good';
        break;
      default:
        overallStatus = 'Excellent';
        break;
    }
  }
}

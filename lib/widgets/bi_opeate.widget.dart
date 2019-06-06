

import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/shadowed_box.widget.dart';
import 'package:flutter/material.dart';

const kYes = 'YES!';
const kNoThanks = 'NO THANKS';

class BiOperate extends StatelessWidget {
  final VoidCallback onPositivePressed;
  final VoidCallback onNegativePressed;
  final String positiveLabel;
  final String negativeLabel;



  const BiOperate({
    Key key,
    @required this.onPositivePressed,
    @required this.onNegativePressed,
    this.positiveLabel = kYes,
    this.negativeLabel = kNoThanks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FractionallySizedBox(
          widthFactor: 0.75,
          child: ShadowedBox(
            borderRadius: BorderRadius.circular(45.0),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              shape: StadiumBorder(),
              color: Colors.white,
              onPressed: onPositivePressed,
              child: AvenirText(
                positiveLabel,
                style: theme.textTheme.subhead.copyWith(
                  color: theme.primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
          SizedBox(width: 16.0, height: 16.0),
        FlatButton(
          shape: StadiumBorder(),
          onPressed: onNegativePressed,
          color: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: AvenirText(
            negativeLabel,
            style: theme.textTheme.subhead.copyWith(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

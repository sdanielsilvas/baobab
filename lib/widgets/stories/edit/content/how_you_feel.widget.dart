import 'package:baobab_app/helper/helper.export.dart';
import 'package:baobab_app/widgets.dart';
import 'package:baobab_app/widgets/question.widget.dart';
import 'package:flutter/material.dart';

final kIconDataList = [
  {Drawable.happy: 'Feliz'},
  {Drawable.blessed: 'Bendecido'},
  {Drawable.lucky: 'Afortunado'},
  {Drawable.good: 'Bien'},
  {Drawable.confused: 'Confundido'},
  {Drawable.stressed: 'Estresado'},
  {Drawable.angry: 'Enojado'},
  {Drawable.anxious: 'Ansioso'},
  {Drawable.down: 'Bajo de ánimo'},
];
const kQuestion = 'Cómo te sentiste a lo largo del día?';

class HowYouFeel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(height: 100.0),
        Question(kQuestion),
        Flexible(child: _Feel()),
        SizedBox(width: 64.0, height: 64.0),
      ],
    );
  }
}

class _Feel extends StatefulWidget {
  @override
  _FeelState createState() {
    return _FeelState();
  }
}

class _FeelState extends State<_Feel> {
  final _controller = PageController(viewportFraction: 0.35);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: kIconDataList.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double iconFactor = 1.0;
            double labelFactor = 1.0;
            if (_controller.position.haveDimensions) {
              iconFactor = _controller.page - index;
              iconFactor = (1 - (iconFactor.abs() * .6)).clamp(0.4, 1.0);

              labelFactor = _controller.page - index;
              labelFactor = (1 - labelFactor.abs()).clamp(0.0, 1.0);
            } else if (index == 1) {
              // 如果是首次加载, 由于haveDimensions为false, 会导致index为1处的item
              // 的value也会是1, 这里手动调整一下value.
              iconFactor = 0.5;
              labelFactor = 0.0;
            }

            return Transform.scale(
              scale: Curves.easeOut.transform(iconFactor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    kIconDataList[index].keys.toList()[0],
                    size: 80.0,
                    color: Colors.white.withOpacity(iconFactor),
                  ),
                  SizedBox(width: 16.0, height: 16.0),
                  QuicksandText(
                    kIconDataList[index].values.toList()[0],
                    style: TextStyle(
                      color: Colors.white.withOpacity(labelFactor),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

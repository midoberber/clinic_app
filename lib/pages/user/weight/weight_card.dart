import 'package:clinic_app/modules/utils/widget_utils.dart'
    show screenAwareSize;
import 'package:clinic_app/pages/user/card_title.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'weight_slider.dart';

class WeightCard extends StatelessWidget {
  final int weight;
  final Function onChanged;

  const WeightCard({Key key, this.weight = 70, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CardTitle("WEIGHT", subtitle: "(kg)"),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenAwareSize(16.0, context)),
              child: _drawSlider(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.isTight
              ? Container()
              : WeightSlider(
                  minValue: 30,
                  maxValue: 200,
                  value: weight,
                  onChanged: onChanged,
                  width: constraints.maxWidth);
        },
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget child;

  const WeightBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
                new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        PhotoView(
          customSize: Size(
            screenAwareSize(18.0, context),
            screenAwareSize(10.0, context),
          ),
          imageProvider: AssetImage("assets/images/weight_arrow.svg"),
        ),
      ],
    );
  }
}

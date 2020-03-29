import 'package:flutter/material.dart';

class CircularUserAvatar extends StatelessWidget {
  final ImageProvider provider;
  final double raduis;
  final Color filterColor;
  final double margin;
  const CircularUserAvatar({
    Key key,
    this.provider,
    this.raduis = 50,
    this.filterColor = Colors.white10, this.margin = 4,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: raduis,
      width: raduis,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(filterColor, BlendMode.colorBurn)),
      ),
    );
  }
}

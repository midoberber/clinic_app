import 'package:flutter/material.dart';

class FadeInNetworkImag extends StatelessWidget {
  final String src;

  const FadeInNetworkImag({Key key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: AssetImage("assets/images/placeholder.png"),
      image: NetworkImage(src),
      fit: BoxFit.fitWidth,
      width: MediaQuery.of(context).size.width,
    );
  }
}

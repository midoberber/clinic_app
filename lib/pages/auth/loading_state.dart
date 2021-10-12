import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clinic_app/modules/app/app_model.dart';

class LoadingState extends StatefulWidget {
  @override
  _LoadingStateState createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {
  @override
  void initState() {
    super.initState();
  }

  void getState() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

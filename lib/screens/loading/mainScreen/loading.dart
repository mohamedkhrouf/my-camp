import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(36, 34, 47, 1),
      child: Center(
        child: SpinKitChasingDots(
          color: Color.fromRGBO(170, 215, 62, 1),
          size: 50.0,
        ),
      ),
    );
  }
}

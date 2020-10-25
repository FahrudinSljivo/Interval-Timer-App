import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:interval_timer_app/utils/colors.dart';

///Simple loader made by wrapping custom loader (added in pubspec.yaml dependencies).
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryTheme,
      child: Center(
        child: SpinKitChasingDots(
          color: ternaryTheme,
          size: 50.0,
        ),
      ),
    );
  }
}

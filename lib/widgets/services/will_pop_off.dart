import 'package:flutter/material.dart';

class WillPopOff extends StatelessWidget {
  const WillPopOff({
    super.key,
    required this.child,
    this.onPop,
    this.onWillPop,
  });

  final Widget child;
  final void Function()? onPop;
  final Future<bool> Function()? onWillPop;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onPop != null) {
          onPop!();
        }

        if (onWillPop != null) {
          return onWillPop!();
        }

        return false;
      },
      child: child,
    );
  }
}

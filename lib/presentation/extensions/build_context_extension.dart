import 'package:flutter/material.dart';

import '../constants/constants_resources.dart';

/// Extension methods for the [BuildContext] class to provide additional utility functions.
extension BuildContextX on BuildContext {
  /// Navigate to the specified page using [Navigator.push].
  void navigateTo(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  /// Navigate to the specified page and remove all previous routes from the stack using [Navigator.pushAndRemoveUntil].
  void pushAndRemoveAll(Widget page) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  /// Show a snackbar with the provided [message].
  ///
  /// Additional parameters:
  /// - [duration]: The duration for which the snackbar should be displayed.
  /// - [backgroundColor]: The background color of the snackbar.
  /// - [hideOnTap]: A flag indicating whether the snackbar should be hidden when tapped.
  void showSnackbar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
    Color? backgroundColor,
    bool hideOnTap = false, // Add this parameter for hiding on tap
  }) {
    final snackBar = SnackBar(
      dismissDirection: DismissDirection.down,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      content: Text(message),
      duration: duration ??
          const Duration(seconds: ConstantsResources.SNACKBAR_DELAY),
      action: action,
      backgroundColor: backgroundColor ?? Colors.blue,
    );

    final scaffoldMessenger = ScaffoldMessenger.of(this);
    final controller = scaffoldMessenger.showSnackBar(snackBar);

    if (hideOnTap) {
      controller.closed.then((_) {
        scaffoldMessenger.hideCurrentSnackBar();
      });
    }
  }
}

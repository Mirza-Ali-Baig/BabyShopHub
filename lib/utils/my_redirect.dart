import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future redirect(context, Widget child) {
  return Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.size,
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}

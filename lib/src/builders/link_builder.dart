import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class LinkBuilder extends MarkdownElementBuilder {
  LinkBuilder({
    TextStyle? textStyle,
    required this.controller,
  }) : super(
          textStyle: const TextStyle(
            color: Color(0xff2196f3),
          ).merge(textStyle),
        );
  final MarkDownController controller;
  @override
  final matchTypes = ['link'];

  @override
  GestureRecognizer? gestureRecognizer(element) {
    return TapGestureRecognizer()
      ..onTap = () => controller.linkTap(
          element.attributes['destination'], element.attributes['title']);
  }
}

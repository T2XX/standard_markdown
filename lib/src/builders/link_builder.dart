import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_coltroller.dart';

import 'builder.dart';

final MarkDownController controller = Get.put(MarkDownController());

class LinkBuilder extends MarkdownElementBuilder {
  LinkBuilder({
    TextStyle? textStyle,
  }) : super(
          textStyle: const TextStyle(
            color: Color(0xff2196f3),
          ).merge(textStyle),
        );

  @override
  final matchTypes = ['link'];

  @override
  GestureRecognizer? gestureRecognizer(element) {
    return TapGestureRecognizer()
      ..onTap = () => controller.linkTap(
          element.attributes['destination'], element.attributes['title']);
  }
}

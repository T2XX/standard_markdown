import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class HeadlineBuilder extends MarkdownElementBuilder {
  HeadlineBuilder();

  @override
  TextStyle? buildTextStyle(element, defaultStyle) {
    return defaultStyle.merge({
      "1": controller.h1TextStyle,
      "2": controller.h2TextStyle,
      "3": controller.h3TextStyle,
      "4": controller.h4TextStyle,
      "5": controller.h5TextStyle,
      "6": controller.h6TextStyle,
    }[element.attributes['level']]);
  }

  @override
  final matchTypes = ['headline'];
  final MarkDownController controller = Get.put(MarkDownController());

  @override
  EdgeInsets? blockPadding(element, parent) => {
        "1": controller.h1Padding,
        "2": controller.h2Padding,
        "3": controller.h3Padding,
        "4": controller.h4Padding,
        "5": controller.h5Padding,
        "6": controller.h6Padding,
      }[element.attributes['level']];
}

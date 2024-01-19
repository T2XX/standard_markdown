import 'package:flutter/material.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class ThematicBreakBuilder extends MarkdownElementBuilder {
  ThematicBreakBuilder({required this.controller});
  MarkDownConfig controller;

  @override
  final matchTypes = ['thematicBreak'];

  @override
  Widget? buildWidget(element, parent) {
    return Divider(
        color: controller.dividerColor,
        height: controller.height,
        thickness: controller.thickness);
  }
}

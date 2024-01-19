import 'package:flutter/material.dart';

import '../../global_coltroller.dart';
import '../helpers/parse_block_padding.dart';
import 'builder.dart';

class BlockquoteBuilder extends MarkdownElementBuilder {
  BlockquoteBuilder(this.controller);
  MarkDownConfig controller;

  @override
  final matchTypes = ['blockquote'];

  @override
  Widget? buildWidget(element, parent) {
    final widget = Container(
        width: double.infinity,
        decoration: controller.blockquoteDecoration,
        padding: controller.blockquoteContentPadding,
        child: super.buildWidget(element, parent));

    final parsedPadding = parseBlockPadding(
        controller.blockquotePadding, element.element.position);

    if (parsedPadding == null) {
      return widget;
    }

    return Padding(padding: parsedPadding, child: widget);
  }
}

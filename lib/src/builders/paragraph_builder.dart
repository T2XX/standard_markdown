import 'package:flutter/material.dart';

import '../../global_coltroller.dart';
import '../helpers/parse_block_padding.dart';
import 'builder.dart';

class ParagraphBuilder extends MarkdownElementBuilder {
  ParagraphBuilder(this.controller);
  MarkDownConfig controller;

  @override
  final matchTypes = ['paragraph'];

  @override
  EdgeInsets? blockPadding(element, parent) {
    // When a list is not tight, add padding to list item
    if (parent.type == 'listItem') {
      return null;
    }

    return parseBlockPadding(
        controller.paragraphPadding, element.element.position);
  }
}

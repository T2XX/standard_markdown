import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

final MarkDownController controller = Get.put(MarkDownController());

class SimpleInlinesBuilder extends MarkdownElementBuilder {
  SimpleInlinesBuilder()
      : super(textStyleMap: {
          'emphasis': controller.emphasisTextStyle.value,
          'strongEmphasis': controller.strongEmphasisTextStyle.value,
          'highlight': controller.highlightTextStyle.value,
          'strikethrough': controller.strikethroughTextStyle.value,
          'subscript': controller.subscriptTextStyle.value,
          'superscript': controller.subscriptTextStyle.value,
          'kbd': controller.kbd.value
        });

  @override
  TextSpan? createText(element, parentStyle) {
    if (element.type != 'hardLineBreak') {
      return null;
    }

    return TextSpan(text: '\n', style: parentStyle);
  }

  @override
  final matchTypes = [
    'emphasis',
    'strongEmphasis',
    'link',
    'hardLineBreak',
    'highlight',
    'strikethrough',
    'emoji',
    'superscript',
    'subscript',
    'kbd',
    'rawHtml',
  ];
}

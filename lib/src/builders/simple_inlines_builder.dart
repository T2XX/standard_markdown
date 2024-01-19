import 'package:flutter/material.dart';
import '../../global_coltroller.dart';
import 'builder.dart';

class SimpleInlinesBuilder extends MarkdownElementBuilder {
  SimpleInlinesBuilder(this.controller)
      : super(textStyleMap: {
          'emphasis': controller.emphasisTextStyle,
          'strongEmphasis': controller.strongEmphasisTextStyle,
          'highlight': controller.highlightTextStyle,
          'strikethrough': controller.strikethroughTextStyle,
          'subscript': controller.subscriptTextStyle,
          'superscript': controller.superscriptTextStyle,
          'kbd': controller.kbdTextStyle
        });
  MarkDownConfig controller;

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
    'rawHtml'
  ];
}

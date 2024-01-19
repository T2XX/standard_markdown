import 'package:flutter/material.dart';
import '../../global_coltroller.dart';
import 'builder.dart';

class CodeSpanBuilder extends MarkdownElementBuilder {
  CodeSpanBuilder(this.controller);
  MarkDownConfig controller;

  @override
  final matchTypes = ['codeSpan'];

  @override
  TextStyle? buildTextStyle(element, defaultStyle) => super
      .buildTextStyle(element, defaultStyle)
      ?.merge(controller.codeSpanTextStyle);

  @override
  Widget? buildWidget(element, parent) {
    final richText = element.children.single as RichText;

    // The purpose of this is to make the RichText has the same line height as
    // it should be while the line height of TextSpan has been changed to 1.
    return renderer.createRichText(richText.text as TextSpan,
        strutStyle: StrutStyle(
            height: controller.codeSpanHeight, forceStrutHeight: true));
  }
}

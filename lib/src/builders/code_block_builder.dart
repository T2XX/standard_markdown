import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:get/get.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class CodeBlockBuilder extends MarkdownElementBuilder {
  CodeBlockBuilder(this.controller);

  final MarkDownConfig controller;

  @override
  final matchTypes = ['codeBlock'];

  @override
  bool replaceLineEndings(String type) => false;

  @override
  TextAlign textAlign(parent) => TextAlign.start;

  @override
  TextSpan buildText(text, parent) {
    // final textContent = text.trimRight();
    // parent.attributes['infoString'];
    final style = const TextStyle(fontFamily: 'monospace').merge(parent.style);
    late List<TextSpan> spans;
    try {
      final prism = Prism(
          mouseCursor: SystemMouseCursors.text,
          style: Get.isDarkMode ? const PrismStyle.dark() : const PrismStyle());
      spans = prism.render(text, parent.attributes['language'] ?? "");
    } catch (e) {
      final prism = Prism(
          mouseCursor: SystemMouseCursors.text,
          style: Get.isDarkMode ? const PrismStyle.dark() : const PrismStyle());
      spans = prism.render(text, 'plain');
    }

    if (spans.isEmpty) {
      return const TextSpan(text: '');
    }

    return TextSpan(
        children: spans, style: style, mouseCursor: MouseCursor.defer);
  }

  @override
  Widget buildWidget(element, parent) {
    Widget child;
    if (element.children.isNotEmpty) {
      final textWidget = element.children.single;
      child = Stack(
        children: [
          textWidget,
          Positioned(
              right: 0,
              top: 0,
              child: controller.copyIconBuilder(textWidget.toString()))
        ],
      );
    } else {
      child = const SizedBox(height: 15);
    }

    return Container(
        width: double.infinity,
        decoration: controller.codeBlockDecoration,
        child: child);
  }
}

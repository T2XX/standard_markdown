import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:get/get.dart';

import '../definition.dart';
import '../widgets/copy_button.dart';
import 'builder.dart';

class CodeBlockBuilder extends MarkdownElementBuilder {
  CodeBlockBuilder({
    TextStyle? textStyle,
    super.context,
    this.padding,
    this.decoration,
    this.copyIconBuilder,
    this.copyIconColor,
  }) : super(
            textStyle: TextStyle(
          color: Get.isDarkMode
              ? const Color(0xffcccccc)
              : const Color(0xff333333),
        ).merge(textStyle));

  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final CopyIconBuilder? copyIconBuilder;
  final Color? copyIconColor;

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
        style: Get.isDarkMode ? const PrismStyle.dark() : const PrismStyle(),
      );
      spans = prism.render(text, parent.attributes['language']!);
    } catch (e) {
      final prism = Prism(
        mouseCursor: SystemMouseCursors.text,
        style: Get.isDarkMode ? const PrismStyle.dark() : const PrismStyle(),
      );
      spans = prism.render(text, 'plain');
    }

    if (spans.isEmpty) {
      return const TextSpan(text: '');
    }

    return TextSpan(
        children: spans, style: style, mouseCursor: renderer.mouseCursor);
  }

  @override
  Widget buildWidget(element, parent) {
    Color backgroundColor;
    if (Get.isDarkMode) {
      backgroundColor = const Color(0xff101010);
    } else {
      backgroundColor = const Color(0xfff0f0f0);
    }

    final defaultDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5),
    );

    Widget child;
    if (element.children.isNotEmpty) {
      final textWidget = element.children.single;
      child = Stack(
        children: [
          textWidget,
          Positioned(
            right: 0,
            top: 0,
            child: CopyButton(
              textWidget,
              iconColor: copyIconColor,
              iconBuilder: copyIconBuilder,
            ),
          ),
        ],
      );
    } else {
      child = const SizedBox(height: 15);
    }

    return Container(
      width: double.infinity,
      decoration: decoration ?? defaultDecoration,
      child: child,
    );
  }
}

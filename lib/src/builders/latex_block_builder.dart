import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../global_coltroller.dart';
import '../../standard_markdown.dart';

class LatexBlockBuilder extends MarkdownElementBuilder {
  LatexBlockBuilder(this.controller);

  MarkDownConfig controller;

  @override
  final matchTypes = ['LatexInline', 'LatexBlock'];

  @override
  Widget? buildWidget(element, parent) {
    final String text = element.attributes['latexContent'] ?? "";
    final ScrollController latexScroll = ScrollController();

    if (element.type == 'LatexInline') {
      return RichText(
          text: WidgetSpan(
              child: Container(
                  padding: EdgeInsets.only(
                      top: controller
                          .getLatexPadding(parent.element.attributes['level'])),
                  child: Scrollbar(
                      controller: latexScroll,
                      child: SingleChildScrollView(
                          controller: latexScroll,
                          scrollDirection: Axis.horizontal,
                          child: Math.tex(text.replaceAll(r"$", ""),
                              textStyle: parentStyle, onErrorFallback: (error) {
                            return Text(text,
                                style: TextStyle(color: Colors.red));
                          }))))));
    } else if (element.type == 'LatexBlock') {
      return RichText(
          text: WidgetSpan(
              child: Align(
                  alignment: Alignment.center,
                  child: Scrollbar(
                      controller: latexScroll,
                      child: SingleChildScrollView(
                          controller: latexScroll,
                          scrollDirection: Axis.horizontal,
                          child: Math.tex(text.replaceAll(r"$", ""),
                              textStyle: parentStyle, onErrorFallback: (error) {
                            return Text("$text\n${error.message}",
                                style: TextStyle(color: Colors.red));
                          }))))));
    } else {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../standard_markdown.dart';

class LatexBlockBuilder extends MarkdownElementBuilder {
  @override
  final matchTypes = ['LatexInline', 'LatexBlock'];

  @override
  Widget? buildWidget(element, parent) {
    final String textContent = element.attributes['latexContent']!;

    if (element.type == 'LatexInline') {
      final level = parent.element.attributes['level'];
      return RichText(
          text: WidgetSpan(
              child: Container(
                  padding: EdgeInsets.only(
                      top: level == '1'
                          ? 16
                          : level == '2'
                              ? 14
                              : level == '3'
                                  ? 12
                                  : level == '4'
                                      ? 10
                                      : level == '5'
                                          ? 8
                                          : 6),
                  child: Math.tex(textContent, textStyle: parentStyle,
                      onErrorFallback: (error) {
                    return Text(textContent);
                  }))));
    } else if (element.type == 'LatexBlock') {
      return RichText(
          text: WidgetSpan(
              child: SizedBox(
                  width: double.infinity,
                  height: 18,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Math.tex(textContent, textStyle: parentStyle,
                          onErrorFallback: (error) {
                        return Text(textContent,
                            style: TextStyle(color: Colors.red));
                      })))));
    } else {
      return null;
    }
  }
}

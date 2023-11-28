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
      return DefaultTextStyle(
          style: parent.style!,
          child: Math.tex(textContent, onErrorFallback: (error) {
            return Text(textContent, style: TextStyle(color: Colors.red));
          }));
    } else if (element.type == 'LatexBlock') {
      return DefaultTextStyle(
          style: parent.style!,
          child: SizedBox(
              width: double.infinity,
              height: 18,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Math.tex(textContent, onErrorFallback: (error) {
                    return Text(textContent,
                        style: TextStyle(color: Colors.red));
                  }))));
    } else {
      return null;
    }
  }
}

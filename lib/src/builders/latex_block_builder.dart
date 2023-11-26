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
            return Text('$textContent', style: TextStyle(color: Colors.red));
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
                    return Text('$textContent',
                        style: TextStyle(color: Colors.red));
                  }))));
    } else {
      return null;
    }
  }
}

class LatexInlineSyntax extends MdInlineSyntax {
  LatexInlineSyntax()
      : super(RegExp(r'(?<!\$)\$[^\$]+\$(?!\$)', multiLine: false));

  @override
  MdInlineObject? parse(MdInlineParser parser, Match match) {
    final input = match.input;
    final matchValue = input.substring(match.start, match.end);

    final markers = parser.source;

    return MdInlineElement('LatexInline',
        markers: markers,
        start: markers.first.end,
        children: parser
            .consumeBy(match[0]!.length)
            .map((e) => MdText.fromSpan(e))
            .toList(),
        attributes: {
          "latexContent": matchValue.substring(1, matchValue.length - 1)
        },
        end: markers.last.start);
  }
}

class LatexBlockSyntax extends MdInlineSyntax {
  LatexBlockSyntax() : super(RegExp(r'(?<!\$)\$\$[^$]*?\$\$(?!\$)'));

  @override
  MdInlineObject? parse(MdInlineParser parser, Match match) {
    final input = match.input;
    final matchValue = input.substring(match.start, match.end);

    final markers = parser.source;

    return MdInlineElement('LatexBlock',
        markers: markers,
        start: markers.first.end,
        children: parser
            .consumeBy(match[0]!.length)
            .map((e) => MdText.fromSpan(e))
            .toList(),
        attributes: {
          "latexContent": matchValue.substring(2, matchValue.length - 2)
        },
        end: markers.last.start);
  }
}

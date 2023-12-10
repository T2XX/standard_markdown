import 'package:dart_markdown/dart_markdown.dart';

class LatexInlineSyntax extends InlineSyntax {
  LatexInlineSyntax() : super(RegExp(r'(?<!\$)\$[^\$]+\$(?!\$)'));

  @override
  InlineObject? parse(InlineParser parser, Match match) {
    final marker = parser.consumeBy(match[0]!.length);
    final content = marker.first.text;
    return InlineElement('LatexInline',
        children: marker.map(Text.fromSpan).toList(),
        end: marker.first.end,
        start: marker.first.start,
        attributes: {'latexContent': content.substring(1, content.length - 1)});
  }
}

class LatexBlockSyntax extends InlineSyntax {
  LatexBlockSyntax() : super(RegExp(r'(?<!\$)\$\$[^$]*?\$\$(?!\$)'));

  @override
  InlineObject? parse(InlineParser parser, Match match) {
    final marker = parser.consumeBy(match[0]!.length);
    final content = marker.first.text;
    return InlineElement('LatexInline',
        children: marker.map(Text.fromSpan).toList(),
        end: marker.first.end,
        start: marker.first.start,
        attributes: {'latexContent': content.substring(2, content.length - 2)});
  }
}

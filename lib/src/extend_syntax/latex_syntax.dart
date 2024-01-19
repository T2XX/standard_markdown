import 'package:dart_markdown/dart_markdown.dart';

class LatexInlineSyntax extends InlineSyntax {
  LatexInlineSyntax() : super(RegExp(r'(?<!\$)\$[^\$]+\$(?!\$)'));

  @override
  InlineObject? parse(InlineParser parser, Match match) {
    final marker = parser.consumeBy(match[0]!.length);
    String content = "";
    if (marker.length > 1) {
      /* rebuiltcontent */
      for (int i = 0; i < marker.length; i++) {
        content += marker[i].text;
        if (i < marker.length - 1) {
          content += r"\";
        }
      }
    } else {
      content = marker.first.text;
    }

    return InlineElement('LatexInline',
        children: marker.map(Text.fromSpan).toList(),
        end: marker.first.end,
        start: marker.first.start,
        attributes: {'latexContent': content});
  }
}

class LatexBlockSyntax extends InlineSyntax {
  LatexBlockSyntax() : super(RegExp(r'(?<!\$)\$\$[^$]*?\$\$(?!\$)'));

  @override
  InlineObject? parse(InlineParser parser, Match match) {
    final marker = parser.consumeBy(match[0]!.length);
    String content = "";
    if (marker.length > 1) {
      /* rebuiltcontent */
      for (int i = 0; i < marker.length; i++) {
        content += marker[i].text;
      }
    } else {
      content = marker.first.text;
    }

    return InlineElement('LatexBlock',
        children: marker.map(Text.fromSpan).toList(),
        end: marker.first.end,
        start: marker.first.start,
        attributes: {'latexContent': content});
  }
}

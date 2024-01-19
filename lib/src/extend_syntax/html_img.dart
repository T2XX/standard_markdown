import 'package:dart_markdown/dart_markdown.dart';

class HtmlImageInlineSyntax extends InlineSyntax {
  HtmlImageInlineSyntax()
      : super(RegExp(r"""<img.*?src=[\"|\']?(.*?)[\"|\']?\s.*?>"""));

  @override
  InlineObject? parse(InlineParser parser, Match match) {
    final marker = parser.consumeBy(match[0]!.length);
    // final content = marker.first.text;
    return InlineElement('image',
        children: marker.map(Text.fromSpan).toList(),
        end: marker.first.end,
        start: marker.first.start,
        attributes: {});
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markdown_prettier/markdown_prettier.dart';
import 'src/definition.dart';
import 'src/style.dart';
import 'src/syntax/latex_syntax.dart';
import 'package:dart_markdown/dart_markdown.dart' as md;

class MarkDownController extends GetxController {
  String data = "";
  RxBool svMode = false.obs;
  RxBool readOnly = false.obs;
  RxBool selectable = true.obs;
  MarkdownStyle styleSheet = MarkdownStyle();
  double listItemMarkerTrailingSpace = 12.0;
  TextStyle codeSpanTextStyle = TextStyle(fontFamily: 'RobotoMono');
  TextStyle codeBlockTextStyle =
      TextStyle(fontSize: 14, letterSpacing: -0.3, fontFamily: 'RobotoMono');

  List<md.Syntax> markdownSyntaxList = [
    LatexBlockSyntax(),
    LatexInlineSyntax()
  ];

  bool enableTaskList = true;
  bool enableSuperscript = true;
  bool enableKbd = true;
  bool enableFootnote = true;
  bool enableAutolinkExtension = true;
  bool forceTightList = true;
  bool enableHtmlBlock = true;
  Color selectionColor = Color(0x4a006ff8);

  /// A function used to modify the parsed AST nodes.
  ///
  /// It is useful for example when need to check if the parsed result contains
  /// any text content:
  ///
  /// ```dart
  /// nodesFilter: (nodes) {
  ///   if (nodes.map((e) => e.textContent).join().isNotEmpty) {
  ///     return nodes;
  ///   }
  ///   return [
  ///     md.BlockElement(
  ///       'paragraph',
  ///       children: [md.Text.fromString('empty')],
  ///     )
  ///   ];
  /// }
  /// ```
  final List<md.Node> Function(List<md.Node> nodes)? nodesFilter = null;

  var elementBuilders = [];

  Widget Function(String text) copyIconBuilder = (text) => Obx(() {
        final RxBool copy = false.obs;
        return IconButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text));
              await Future.delayed(const Duration(seconds: 1)).then((value) {
                if (copy.value) {
                } else {
                  copy.value = true;
                }
              });
              copy.value = false;
            },
            icon: Icon(copy.value ? Icons.check : Icons.copy));
      });
  Widget Function(
          MarkdownListType style, String? number, TextStyle listItemStyle)
      markdownListItemMarkerBuilder = (listType, number, listItemStyle) {
    return RichText(
        text: TextSpan(
            text:
                listType == MarkdownListType.unordered ? '\u2022' : '$number.',
            style: TextStyle(
              color: listItemStyle.color?.withOpacity(0.75) ?? Colors.black,
              fontSize: listType == MarkdownListType.unordered
                  ? (listItemStyle.fontSize ?? 16) * 1.4
                  : (listItemStyle.fontSize ?? 16) * 0.96,
            )),
        strutStyle: StrutStyle(
          height: listItemStyle.height,
          forceStrutHeight: true,
        ),
        textAlign: TextAlign.right);
  };

  void loadFromSring(String text, bool parse) {
    if (parse) {
      data = MarkdownPrettier().parse(text);
    } else {
      data = text;
    }
  }

  String formate(String text) {
    return MarkdownPrettier().parse(text);
  }

  /* H1Style */
  TextStyle h1TextStyle = TextStyle(fontSize: 16 * 2);
  TextStyle h2TextStyle = TextStyle(fontSize: 16 * 1.8);
  TextStyle h3TextStyle = TextStyle(fontSize: 16 * 1.6);
  TextStyle h4TextStyle = TextStyle(fontSize: 16 * 1.4);
  TextStyle h5TextStyle = TextStyle(fontSize: 16 * 1.2);
  TextStyle h6TextStyle = TextStyle(fontSize: 16 * 1.1);
  EdgeInsets h1Padding = EdgeInsets.only(bottom: 6);
  EdgeInsets h2Padding = EdgeInsets.only(bottom: 6);
  EdgeInsets h3Padding = EdgeInsets.only(bottom: 6);
  EdgeInsets h4Padding = EdgeInsets.only(bottom: 4);
  EdgeInsets h5Padding = EdgeInsets.only(bottom: 4);
  EdgeInsets h6Padding = EdgeInsets.only(bottom: 4);
  /* Link Config */
  Function(String? href, String? title) linkTap = (href, title) {
    print({href, title});
  };

  /* inlines Config */
  Rx<TextStyle> emphasisTextStyle = TextStyle(fontStyle: FontStyle.italic).obs;
  Rx<TextStyle> strongEmphasisTextStyle =
      TextStyle(fontWeight: FontWeight.w700).obs;
  Rx<TextStyle> highlightTextStyle =
      TextStyle(backgroundColor: const Color(0xffffbb00)).obs;
  Rx<TextStyle> strikethroughTextStyle = TextStyle(
          color: Color(0xffff6666), decoration: TextDecoration.lineThrough)
      .obs;
  Rx<TextStyle> subscriptTextStyle =
      TextStyle(fontFeatures: [FontFeature.subscripts()]).obs;
  Rx<TextStyle> superscriptTextStyle =
      TextStyle(fontFeatures: [FontFeature.superscripts()]).obs;
  Rx<TextStyle> kbd = TextStyle().obs;
}

import 'package:dart_markdown/dart_markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_prettier/markdown_prettier.dart';

import 'src/syntax/latex_Syntax.dart';

class MarkDownController extends GetxController {
  RxBool svMode = false.obs;
  RxInt currentEdting = (-1).obs;
  void loadFromSring(String text) {
    final markdown = md.Markdown(
        enableAtxHeading: true,
        enableAutolink: true,
        enableAutolinkExtension: true,
        enableBackslashEscape: true,
        enableBlankLine: true,
        enableBlockquote: true,
        enableCodeSpan: true,
        enableEmoji: true,
        enableEmphasis: true,
        enableFencedBlockquote: true,
        enableFencedCodeBlock: true,
        enableFootnote: true,
        enableHardLineBreak: true,
        enableHeadingId: true,
        enableHighlight: true,
        enableHtmlBlock: true,
        enableImage: true,
        enableIndentedCodeBlock: true,
        enableKbd: true,
        enableLink: true,
        enableLinkReferenceDefinition: true,
        enableList: true,
        enableParagraph: true,
        enableRawHtml: true,
        enableSetextHeading: true,
        enableSoftLineBreak: true,
        enableStrikethrough: true,
        enableSubscript: true,
        enableSuperscript: true,
        enableTable: true,
        enableTaskList: true,
        enableThematicBreak: true,
        extensions: [LatexBlockSyntax(), LatexInlineSyntax()]);
    //markdown.parse(text);
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
  TextStyle h6TextStyle = TextStyle(fontSize: 16);
  EdgeInsets h1Padding = EdgeInsets.only(bottom: 12);
  EdgeInsets h2Padding = EdgeInsets.only(bottom: 9);
  EdgeInsets h3Padding = EdgeInsets.only(bottom: 6);
  EdgeInsets h4Padding = EdgeInsets.only(bottom: 4);
  EdgeInsets h5Padding = EdgeInsets.only(bottom: 3);
  EdgeInsets h6Padding = EdgeInsets.only(bottom: 3);
}

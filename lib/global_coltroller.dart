import 'package:dart_markdown/dart_markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_prettier/markdown_prettier.dart';

import 'src/syntax/latex_Syntax.dart';

class MarkDownController extends GetxController {
  String type = '';
  List<md.Node> astTree = [];

  RxList<Widget> markdownWidget = [SizedBox()].obs;
  RxBool svMode = false.obs;
  RxInt currentEdting = (-1).obs;
  Map<String, Function(Map args)> renders = {"atxHeading": (args) {}};
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
    astTree = markdown.parse(text);
  }

  String formate(String text) {
    return MarkdownPrettier().parse(text);
  }
}

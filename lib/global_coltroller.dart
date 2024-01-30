import 'dart:ui';
import 'package:dart_markdown/dart_markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:markdown_prettier/markdown_prettier.dart';
import 'src/extend_syntax/latex_syntax.dart';

class MarkDownConfig extends GetxController {
  /* base config */
  TextDirection textdirection = TextDirection.ltr;
  String svEditHint = "start from here";
  TextAlign defaultTextAlign = TextAlign.center;
  String replaceTabsWith = "    ";
  TextStyle defaultTextStyle = TextStyle(
      fontSize: 16,
      height: 1.5,
      color: Get.textTheme.bodyMedium?.color ?? const Color(0xff333333));
  /* Paragraph */
  EdgeInsets paragraphPadding = EdgeInsets.only(bottom: 12.0);
  /* toolbar icon */
  bool h1Icon = true;
  /* toolbar */
  void toolbarFormat(
      TextEditingController data, String type, FocusNode focusNode) {
    final int selectStart = data.selection.start;
    final int selectEnd = data.selection.end;

    switch (type) {
      case "H1":
        final RegExpMatch? match = RegExp("^(#){1,6} ")
            .firstMatch(data.text.substring(selectStart, selectEnd));
        if (match != null) {
          /* cancel header */
          data.text =
              "${data.text.substring(0, selectStart)}# ${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 2,
              extentOffset: selectEnd - (match.end - match.start - 2));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}# ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 2, extentOffset: selectEnd + 2);
          focusNode.requestFocus();
        }
        break;
      case "H2":
        final RegExpMatch? match = RegExp("^(#){1,6} ")
            .firstMatch(data.text.substring(selectStart, selectEnd));
        if (match != null) {
          /* cancel header */
          data.text =
              "${data.text.substring(0, selectStart)}## ${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 3,
              extentOffset: selectEnd - (match.end - match.start - 3));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}## ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 3, extentOffset: selectEnd + 3);
          focusNode.requestFocus();
        }
        break;
      case "H3":
        final RegExpMatch? match = RegExp("^(#){1,6} ")
            .firstMatch(data.text.substring(selectStart, selectEnd));
        if (match != null) {
          /* cancel header */
          data.text =
              "${data.text.substring(0, selectStart)}### ${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 4,
              extentOffset: selectEnd - (match.end - match.start - 4));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}### ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 4, extentOffset: selectEnd + 4);
          focusNode.requestFocus();
        }
        break;
      case "H4":
        final RegExpMatch? match = RegExp("^(#){1,6} ")
            .firstMatch(data.text.substring(selectStart, selectEnd));
        if (match != null) {
          /* cancel header */
          data.text =
              "${data.text.substring(0, selectStart)}#### ${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 5,
              extentOffset: selectEnd - (match.end - match.start - 5));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}#### ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 5, extentOffset: selectEnd + 5);
          focusNode.requestFocus();
        }
        break;
      case "H5":
        final RegExpMatch? match = RegExp("^(#){1,6} ")
            .firstMatch(data.text.substring(selectStart, selectEnd));
        if (match != null) {
          data.text =
              "${data.text.substring(0, selectStart)}##### ${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 6,
              extentOffset: selectEnd - (match.end - match.start - 6));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}##### ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 6, extentOffset: selectEnd + 6);
          focusNode.requestFocus();
        }
        break;
      case "H6":
        final RegExpMatch? match = RegExp("^(#){1,6} ")
            .firstMatch(data.text.substring(selectStart, selectEnd));
        if (match != null) {
          data.text =
              "${data.text.substring(0, selectStart)}###### ${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 7,
              extentOffset: selectEnd - (match.end - match.start - 7));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}###### ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 7, extentOffset: selectEnd + 7);
          focusNode.requestFocus();
        }
        break;
      case "Bold":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? match =
            RegExp(r"\*\*(.*?)\*\*").firstMatch(destination);
        if (match != null) {
          data.text = data.text.substring(0, selectStart + match.start) +
              destination.substring(match.start + 2, match.end - 2) +
              data.text.substring(
                  selectEnd - destination.length + match.end, data.text.length);
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd - 4);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}**${data.text.substring(selectStart, selectEnd)}**${data.text.substring(selectEnd, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd + 4);
          focusNode.requestFocus();
        }
        break;
      case "Del":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? match = RegExp("~~(.*?)~~").firstMatch(destination);
        if (match != null) {
          data.text = data.text.substring(0, selectStart + match.start) +
              destination.substring(match.start + 2, match.end - 2) +
              data.text.substring(
                  selectEnd - destination.length + match.end, data.text.length);
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd - 4);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}~~${data.text.substring(selectStart, selectEnd).replaceFirst("\n", " ")}~~${data.text.substring(selectEnd, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 2, extentOffset: selectEnd + 2);
          focusNode.requestFocus();
        }
        break;
      case "Italic":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? match = RegExp("_(.*?)_").firstMatch(destination);
        if (match != null) {
          data.text = data.text.substring(0, selectStart + match.start) +
              destination.substring(match.start + 1, match.end - 1) +
              data.text.substring(
                  selectEnd - destination.length + match.end, data.text.length);
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd - 2);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}_${data.text.substring(selectStart, selectEnd).replaceFirst("\n", " ")}_${data.text.substring(selectEnd, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd + 2);
          focusNode.requestFocus();
        }
        break;
      case "Link":
        data.text =
            "${data.text.substring(0, selectStart)}[](${data.text.substring(selectStart, selectEnd).trimRight()})${data.text.substring(selectEnd, data.text.length)}";
        data.selection =
            TextSelection.fromPosition(TextPosition(offset: selectStart + 1));
        focusNode.requestFocus();

        break;
      case "Check":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? match =
            RegExp(r"^(- \[ \] )").firstMatch(destination);
        if (match != null) {
          data.text =
              "${data.text.substring(0, selectStart)}${data.text.substring(selectStart + (match.end - match.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart,
              extentOffset: selectEnd - (match.end - match.start));
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}- [ ] ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 6, extentOffset: selectEnd + 6);
          focusNode.requestFocus();
        }
        break;
      case "Uncheck":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? matcha =
            RegExp(r"^(- \[x\] )").firstMatch(destination);
        final RegExpMatch? matchA =
            RegExp(r"^(- \[X\] )").firstMatch(destination);
        if (matchA != null) {
          data.text =
              "${data.text.substring(0, selectStart)}${data.text.substring(selectStart + (matchA.end - matchA.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart,
              extentOffset: selectEnd - (matchA.end - matchA.start));
          focusNode.requestFocus();
        } else if (matcha != null) {
          data.text =
              "${data.text.substring(0, selectStart)}${data.text.substring(selectStart + (matcha.end - matcha.start), data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart,
              extentOffset: selectEnd - (matcha.end - matcha.start));
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}- [x] ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 6, extentOffset: selectEnd + 6);
          focusNode.requestFocus();
        }
        break;
      case "Photo":
        data.text =
            "${data.text.substring(0, selectStart)}![](${data.text.substring(selectStart, selectEnd).trimRight()})${data.text.substring(selectEnd, data.text.length)}";
        data.selection =
            TextSelection.fromPosition(TextPosition(offset: selectStart + 2));
        focusNode.requestFocus();
        break;
      case "Code":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? match =
            RegExp(r"```[.\s\S]+```").firstMatch(destination);
        if (match != null) {
          data.text = data.text.substring(0, selectStart + match.start) +
              destination.substring(match.start + 3, match.end - 3) +
              data.text.substring(
                  selectEnd - destination.length + match.end, data.text.length);
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd - 6);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}```\n${data.text.substring(selectStart, selectEnd)}\n```${data.text.substring(selectEnd, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 4, extentOffset: selectEnd + 4);
          focusNode.requestFocus();
        }
        break;
      case "BulletList":
        final String destination = data.text.substring(selectStart, selectEnd);
        final RegExpMatch? match = RegExp("- ").firstMatch(destination);
        if (match != null) {
          data.text = data.text.substring(0, selectStart + match.start) +
              destination.substring(match.start + 2, match.end) +
              data.text.substring(
                  selectEnd - destination.length + match.end, data.text.length);
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd - 2);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}- ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 2, extentOffset: selectEnd + 2);
          focusNode.requestFocus();
        }
        break;
      case "NumbertList":
        final String destination = data.text.substring(selectStart, selectEnd);
        final Iterable<RegExpMatch> match =
            RegExp(r"(?:[0-9]+\.)").allMatches(destination);
        if (match.isEmpty) {
          data.text =
              "${data.text.substring(0, selectStart)}1. ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 3, extentOffset: selectEnd + 3);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectEnd)}\n${int.parse(destination.substring(match.last.start).trimLeft()[0]) + 1}. ${data.text.substring(selectEnd, data.text.length)}";
          data.selection =
              TextSelection.fromPosition(TextPosition(offset: selectEnd + 4));
          focusNode.requestFocus();
        }
        break;
      case "Divider":
        data.text =
            "${data.text.substring(0, selectStart)}---${data.text.substring(selectEnd, data.text.length)}";
        data.selection =
            TextSelection.fromPosition(TextPosition(offset: selectStart + 3));
        focusNode.requestFocus();
        break;
      case "Quote":
        final String destination = data.text.substring(selectStart, selectEnd);
        final Iterable<RegExpMatch> match =
            RegExp("^>.*").allMatches(destination);
        if (match.isEmpty) {
          data.text =
              "${data.text.substring(0, selectStart)}> ${data.text.substring(selectStart, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart + 2, extentOffset: selectEnd + 2);
          focusNode.requestFocus();
        } else {
          data.text =
              "${data.text.substring(0, selectStart)}${data.text.substring(selectStart + 2, data.text.length)}";
          data.selection = TextSelection(
              baseOffset: selectStart, extentOffset: selectEnd - 2);
          focusNode.requestFocus();
        }
        break;
      default:
        data.selection =
            TextSelection(baseOffset: selectStart, extentOffset: selectEnd - 2);
        focusNode.requestFocus();
    }
  }

  String toolbarH1Tip = "H1";
  String toolbarH2Tip = "H2";
  String toolbarH3Tip = "H3";
  String toolbarH4Tip = "H4";
  String toolbarH5Tip = "H5";
  String toolbarH6Tip = "H6";

  String toolbarBoldTip = "Bold";
  String toolbarItalicTip = "Italic";
  String toolbarDelTip = "Del";
  String toolbarLinkTip = "Link";
  String toolbarUnCheckBoxTip = "UnCheckBox";
  String toolbarCheckBoxTip = "CheckBox";

  String toolbarPhotoTip = "Photo";
  String toolbarCodeBlockTip = "CodeBlock";
  String toolbarNumbertListTip = "NumbertList";
  String toolbarBulletListTip = "BulletList";
  String toolbarQuoteTip = "Quote";
  String toolbarDividerTip = "Divider";

  Decoration toolbarDecoration = BoxDecoration(
      color: Get.theme.colorScheme.primaryContainer.withOpacity(0.6),
      borderRadius: BorderRadius.circular(12));
  /* codeBlock */
  TextStyle codeBlockTextStyle =
      TextStyle(fontSize: 14, letterSpacing: -0.3, fontFamily: 'RobotoMono');
  BoxDecoration codeBlockDecoration = BoxDecoration(
      color: Get.isDarkMode ? const Color(0xff101010) : const Color(0xfff0f0f0),
      borderRadius: BorderRadius.circular(5));

  /* codeSpan */
  double codeSpanHeight = 1;
  TextStyle codeSpanTextStyle = TextStyle(
      fontFamily: 'monospace',
      color: Get.isDarkMode ? Color(0Xffca4219) : Color(0xff8b1c1c),
      backgroundColor:
          Get.isDarkMode ? Color(0Xff424242) : Colors.grey.withAlpha(48),
      height: 1);
  /* table */
  TableBorder tableBorder = TableBorder(
      top: BorderSide(color: Color(0xffcccccc)),
      left: BorderSide(color: Color(0xffcccccc)),
      right: BorderSide(color: Color(0xffcccccc)),
      bottom: BorderSide(color: Color(0xffcccccc)),
      horizontalInside: BorderSide(color: Color(0xffcccccc)),
      verticalInside: BorderSide(color: Color(0xffcccccc)));
  EdgeInsets tableCellPadding = EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0);
  IntrinsicColumnWidth tableColumnWidth = IntrinsicColumnWidth();
  BoxDecoration? tableRowDecoration;
  MarkdownAlternating? tableRowDecorationAlternating;
  /* footnote */
  TextStyle footNoteStyle =
      TextStyle(fontFeatures: [FontFeature.superscripts()]);

  BoxDecoration? footnoteReferenceDecoration;
  EdgeInsets? footnoteReferencePadding;
  TextStyle? footnoteReference;
  /* list */
  double listItemMinIndent = 30.0;
  double listItemMarkerTrailingSpace = 12.0;
  TextStyle orderedListTextStyle = TextStyle();
  TextStyle bulletListTextStyle = TextStyle();
  TextStyle listItemTextStyle = TextStyle();
  /* blockquote */
  BoxDecoration blockquoteDecoration = BoxDecoration(
      border: Border(
          left: BorderSide(
              color: Get.isDarkMode
                  ? const Color(0xff777777)
                  : const Color(0xffcccccc),
              width: 5)));
  EdgeInsets blockquoteContentPadding = EdgeInsets.only(left: 20);
  EdgeInsets blockquotePadding = EdgeInsets.zero;

  /* enable block */
  bool enableTaskList = true;
  bool enableSuperscript = true;
  bool enableKbd = true;
  bool enableFootnote = true;
  bool enableAutolinkExtension = true;
  bool forceTightList = true;
  bool enableHtmlBlock = true;
  Color selectionColor = Color(0x4a006ff8);
  double getLatexPadding(String? level) {
    switch (level) {
      case '1':
        return 16;
      case '2':
        return 14;
      case '3':
        return 12;
      case '4':
        return 10;
      case '5':
        return 8;
      default:
        return 6;
    }
  }

  Widget Function(String text) copyIconBuilder = (text) {
    final RxBool copy = false.obs;
    return IconButton(
        onPressed: () async {
          copy.value = true;
          await Future.delayed(const Duration(seconds: 1)).then((value) async {
            await Clipboard.setData(ClipboardData(text: text));
            copy.value = false;
          });
        },
        icon: Obx(() => Icon(copy.value ? Icons.check : Icons.copy)));
  };
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

  void formate(TextEditingController data) =>
      data.text = MarkdownPrettier().parse(data.text);

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
  TextStyle linkTextstyle = TextStyle(color: Colors.blue);
  Function(String? href, String? title) linkTap = (href, title) {
    print({href, title});
  };

  /* inlines Config */
  TextStyle emphasisTextStyle = TextStyle(fontStyle: FontStyle.italic);
  TextStyle strongEmphasisTextStyle = TextStyle(fontWeight: FontWeight.w700);
  TextStyle highlightTextStyle = TextStyle(
      backgroundColor:
          Get.isDarkMode ? const Color(0xffffbb00) : const Color(0xffffee00));
  TextStyle strikethroughTextStyle = TextStyle(
      color: Color(0xffff6666), decoration: TextDecoration.lineThrough);
  TextStyle subscriptTextStyle =
      TextStyle(fontFeatures: [FontFeature.subscripts()]);
  TextStyle superscriptTextStyle =
      TextStyle(fontFeatures: [FontFeature.superscripts()]);
  TextStyle kbdTextStyle = TextStyle();

  /* divider */
  Color dividerColor = Colors.grey;
  double height = 5;
  double thickness = 2;

  /* extend Syntax */
  List<md.Syntax> markdownSyntaxList = [
    LatexBlockSyntax(),
    LatexInlineSyntax()
  ];
  /* extend Builder */
  List elementBuilders = [];

  /* function */
  final List<md.Node> Function(List<md.Node> nodes)? nodesFilter = null;
  /* 
  A function used to modify the parsed AST nodes.
  
   It is useful for example when need to check if the parsed result contains
   any text content:
  
   ```dart
   nodesFilter: (nodes) {
     if (nodes.map((e) => e.textContent).join().isNotEmpty) {
       return nodes;
     }
     return [
       md.BlockElement(
         'paragraph',
         children: [md.Text.fromString('empty')],
       )
     ];
   } 
  */
}

/// Enumeration of the ways to alternate the table row background.
enum MarkdownAlternating { odd, even }

/// Enumeration of list types.
enum MarkdownListType { ordered, unordered }

/// Alias name of BlockSyntax from dart_markdown package.
typedef MdBlockSyntax = md.BlockSyntax;

/// Alias name of InlineSyntax from dart_markdown package.
typedef MdInlineSyntax = md.InlineSyntax;

/// Alias name of Node from dart_markdown package.
typedef MdNode = md.Node;

/// Alias name of InlineObject from dart_markdown package.
typedef MdInlineObject = md.InlineObject;

/// Alias name of InlineElement from dart_markdown package.
typedef MdInlineElement = md.InlineElement;

/// Alias name of Element from dart_markdown package.
typedef MdElement = md.Element;

/// Alias name of BlockElement from dart_markdown package.
typedef MdBlockElement = md.BlockElement;

/// Alias name of Text from dart_markdown package.
typedef MdText = md.Text;

/// Alias name of InlineParser from dart_markdown package.
typedef MdInlineParser = md.InlineParser;

/// Alias name of BlockParser from dart_markdown package.
typedef MdBlockParser = md.BlockParser;

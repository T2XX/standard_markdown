import 'package:flutter/material.dart';
import 'definition.dart';

class MarkdownStyle {
  const MarkdownStyle({
    this.textStyle,
    this.paragraph,
    this.paragraphPadding = const EdgeInsets.only(bottom: 12.0),
    this.blockquote,
    this.blockquoteDecoration,
    this.blockquotePadding,
    this.blockquoteContentPadding,
    this.footnoteReferenceDecoration,
    this.footnoteReferencePadding,
    this.dividerColor,
    this.dividerHeight,
    this.dividerThickness,
    this.emphasis,
    this.strongEmphasis,
    this.highlight,
    this.strikethrough,
    this.subscript,
    this.superscript,
    this.kbd,
    this.footnote,
    this.footnoteReference,
    this.link,
    this.codeSpan,
    this.list,
    this.listItem,
    this.listItemMarker,
    this.listItemMarkerTrailingSpace,
    this.listItemMinIndent,
    this.checkbox,
    this.table,
    this.tableHead,
    this.tableBody,
    this.tableBorder,
    this.tableRowDecoration,
    this.tableRowDecorationAlternating,
    this.tableCellPadding,
    this.tableColumnWidth,
    this.codeBlock,
    this.codeblockPadding,
    this.codeblockDecoration,
    this.blockSpacing = 8.0,
    this.copyIconColor,
  });

  final TextStyle? textStyle;

  final TextStyle? paragraph;
  final EdgeInsets? paragraphPadding;
  final TextStyle? blockquote;
  final BoxDecoration? blockquoteDecoration;
  final EdgeInsets? blockquotePadding;
  final EdgeInsets? blockquoteContentPadding;
  final BoxDecoration? footnoteReferenceDecoration;
  final EdgeInsets? footnoteReferencePadding;
  final Color? dividerColor;
  final double? dividerHeight;
  final double? dividerThickness;
  final TextStyle? emphasis;
  final TextStyle? strongEmphasis;
  final TextStyle? highlight;
  final TextStyle? strikethrough;
  final TextStyle? subscript;
  final TextStyle? superscript;
  final TextStyle? kbd;
  final TextStyle? footnote;
  final TextStyle? footnoteReference;
  final TextStyle? link;
  final TextStyle? codeSpan;
  final TextStyle? list;
  final TextStyle? listItem;
  final TextStyle? listItemMarker;
  final double? listItemMarkerTrailingSpace;
  final double? listItemMinIndent;
  final ButtonStyle? checkbox;
  final TextStyle? table;
  final TextStyle? tableHead;
  final TextStyle? tableBody;
  final TableBorder? tableBorder;
  final BoxDecoration? tableRowDecoration;
  final MarkdownAlternating? tableRowDecorationAlternating;
  final EdgeInsets? tableCellPadding;
  final TableColumnWidth? tableColumnWidth;
  final TextStyle? codeBlock;
  final EdgeInsets? codeblockPadding;
  final BoxDecoration? codeblockDecoration;
  final Color? copyIconColor;

  /// The vertical space between two block elements.
  final double blockSpacing;
}

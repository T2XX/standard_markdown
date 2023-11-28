import 'package:dart_markdown/dart_markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:standard_markdown/src/syntax/latex_Syntax.dart';

import 'builders/builder.dart';
import 'definition.dart';
import 'renderer.dart';
import 'style.dart';

class StandardMarkdown extends StatefulWidget {
  const StandardMarkdown(
    this.data, {
    this.styleSheet,
    this.onTapLink,
    this.listItemMarkerBuilder,
    this.imageBuilder,
    this.enableTaskList = false,
    this.enableSubscript = false,
    this.enableSuperscript = false,
    this.enableKbd = false,
    this.enableFootnote = false,
    this.enableAutolinkExtension = true,
    this.forceTightList = false,
    this.enableImageSize = false,
    this.elementBuilders = const [],
    this.syntaxExtensions = const [],
    this.nodesFilter,
    this.selectable,
    this.selectionColor,
    this.copyIconBuilder,
    Key? key,
  }) : super(key: key);

  final String data;
  final bool enableTaskList;
  final bool enableImageSize;
  final bool enableSubscript;
  final bool enableSuperscript;
  final bool enableKbd;
  final bool enableFootnote;
  final bool enableAutolinkExtension;
  final bool forceTightList;
  final MarkdownImageBuilder? imageBuilder;
  final MarkdownStyle? styleSheet;
  final MarkdownTapLinkCallback? onTapLink;
  final MarkdownListItemMarkerBuilder? listItemMarkerBuilder;
  final List<MarkdownElementBuilder> elementBuilders;
  final List<md.Syntax> syntaxExtensions;
  final Color? selectionColor;
  final bool? selectable;
  final CopyIconBuilder? copyIconBuilder;

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
  final List<md.Node> Function(List<md.Node> nodes)? nodesFilter;

  @override
  State<StandardMarkdown> createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<StandardMarkdown> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectable == false) {
      return _buildMarkdown();
    } else {
      return SelectionArea(
        child: Builder(
          builder: (context) => _buildMarkdown(
            selectionRegistrar: SelectionContainer.maybeOf(context),
          ),
        ),
      );
    }
  }

  Widget _buildMarkdown({SelectionRegistrar? selectionRegistrar}) {
    final markdown = md.Markdown(
      enableHtmlBlock: false,
      enableRawHtml: true,
      enableHighlight: true,
      enableStrikethrough: true,
      enableTaskList: widget.enableTaskList,
      enableSubscript: widget.enableSubscript,
      enableSuperscript: widget.enableSuperscript,
      enableKbd: widget.enableKbd,
      enableFootnote: widget.enableFootnote,
      enableAutolinkExtension: widget.enableAutolinkExtension,
      forceTightList: widget.forceTightList,
      extensions: [
        LatexBlockSyntax(),
        LatexInlineSyntax(),
        ...widget.syntaxExtensions
      ],
    );

    final renderer = MarkdownRenderer(
        context: context,
        styleSheet: widget.styleSheet ?? const MarkdownStyle(),
        onTapLink: widget.onTapLink,
        enableImageSize: widget.enableImageSize,
        imageBuilder: widget.imageBuilder,
        listItemMarkerBuilder: widget.listItemMarkerBuilder,
        elementBuilders: widget.elementBuilders,
        selectionColor: widget.selectionColor ?? const Color(0x4a006ff8),
        selectionRegistrar: selectionRegistrar,
        copyIconBuilder: widget.copyIconBuilder);

    List<md.Node> astNodes;
    astNodes = markdown.parse(widget.data);

    try {
      astNodes = markdown.parse(widget.data);
      if (widget.nodesFilter != null) {
        astNodes = widget.nodesFilter!(astNodes);
      }
    } catch (_) {
      // Render the entire text as a paragraph if parse fails.
      final textNode = md.Text.fromString(widget.data);
      astNodes = [
        md.BlockElement(
          'paragraph',
          start: textNode.start,
          end: textNode.end,
          children: [textNode],
        ),
      ];
    }

    final children = renderer.render(astNodes);

    Widget markdownWidget;
    if (children.length > 1) {
      markdownWidget = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children);
    } else if (children.length == 1) {
      markdownWidget = children.single;
    } else {
      markdownWidget = const SizedBox.shrink();
    }

    return markdownWidget;
  }
}

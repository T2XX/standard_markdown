import 'package:dart_markdown/dart_markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../global_coltroller.dart';
import 'renderer.dart';

class StandardMarkdown extends StatelessWidget {
  StandardMarkdown({super.key, required this.controller});

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
  final MarkDownController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.selectable.value) {
      return SelectionArea(
          child: Builder(
              builder: (context) => _buildMarkdown(
                  context: context,
                  selectionRegistrar: SelectionContainer.maybeOf(context))));
    } else {
      return _buildMarkdown(context: context);
    }
  }

  Widget _buildMarkdown(
      {required BuildContext context, SelectionRegistrar? selectionRegistrar}) {
    final markdown = md.Markdown(
        enableHtmlBlock: false,
        enableRawHtml: true,
        enableHighlight: true,
        enableStrikethrough: true,
        enableTaskList: controller.enableTaskList,
        enableSubscript: true,
        enableSuperscript: controller.enableSuperscript,
        enableKbd: controller.enableKbd,
        enableFootnote: controller.enableFootnote,
        enableAutolinkExtension: controller.enableAutolinkExtension,
        forceTightList: controller.forceTightList,
        extensions: controller.markdownSyntaxList);

    final renderer = MarkdownRenderer(
        context: context,
        selectionRegistrar: selectionRegistrar,
        controller: controller);

    List<md.Node> astNodes;

    try {
      astNodes = markdown.parse(controller.data);
      if (controller.nodesFilter != null) {
        astNodes = controller.nodesFilter!(astNodes);
      }
    } catch (_) {
      // Render the entire text as a paragraph if parse fails.
      final textNode = md.Text.fromString(controller.data);
      astNodes = [
        md.BlockElement('paragraph',
            start: textNode.start, end: textNode.end, children: [textNode]),
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

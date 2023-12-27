import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../global_coltroller.dart';
import 'ast.dart';
import 'builders/blockquote_builder.dart';
import 'builders/builder.dart';
import 'builders/code_block_builder.dart';
import 'builders/code_span_builder.dart';
import 'builders/footnote_builder.dart';
import 'builders/headline_builder.dart';
import 'builders/image_builder.dart';
import 'builders/latex_block_builder.dart';
import 'builders/link_builder.dart';
import 'builders/list_builder.dart';
import 'builders/paragraph_builder.dart';
import 'builders/simple_inlines_builder.dart';
import 'builders/table_bilder.dart';
import 'builders/thematic_break_builder.dart';
import 'definition.dart';
import 'extensions.dart';
import 'helpers/inline_wraper.dart';
import 'helpers/merge_rich_text.dart';
import 'models/markdown_tree_element.dart';
import 'transformer.dart';

class MarkdownRenderer implements NodeVisitor {
  MarkdownRenderer({
    BuildContext? context,
    required this.controller,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownCheckboxBuilder? checkboxBuilder,
    MarkdownImageBuilder? imageBuilder,
    bool enableImageSize = false,
    TextAlign? textAlign,
    SelectionRegistrar? selectionRegistrar,
  })  : _selectionRegistrar = selectionRegistrar,
        _defaultTextStyle = TextStyle(
          fontSize: 16,
          height: 1.5,
          color: (context != null
                  ? Theme.of(context).textTheme.bodyMedium?.color
                  : null) ??
              const Color(0xff333333),
        ),
        _textAlign = textAlign ?? TextAlign.start {
    final defaultBuilders = [
      HeadlineBuilder(controller: controller),
      LatexBlockBuilder(),
      SimpleInlinesBuilder(
        context: context,
        emphasis: controller.styleSheet.emphasis,
        strongEmphasis: controller.styleSheet.strongEmphasis,
        highlight: controller.styleSheet.highlight,
        strikethrough: controller.styleSheet.strikethrough,
        subscript: controller.styleSheet.subscript,
        superscript: controller.styleSheet.superscript,
        kbd: controller.styleSheet.kbd,
      ),
      ThematicBreakBuilder(
        color: controller.styleSheet.dividerColor,
        height: controller.styleSheet.dividerHeight,
        thickness: controller.styleSheet.dividerThickness,
      ),
      ParagraphBuilder(
        textStyle: controller.styleSheet.paragraph,
        padding: controller.styleSheet.paragraphPadding,
      ),
      CodeSpanBuilder(
          context: context, textStyle: controller.styleSheet.codeSpan),
      LinkBuilder(
          controller: controller, textStyle: controller.styleSheet.link),
      TableBuilder(
        table: controller.styleSheet.table,
        tableHead: controller.styleSheet.tableHead,
        tableBody: controller.styleSheet.tableBody,
        tableBorder: controller.styleSheet.tableBorder,
        tableRowDecoration: controller.styleSheet.tableRowDecoration,
        tableRowDecorationAlternating:
            controller.styleSheet.tableRowDecorationAlternating,
        tableCellPadding: controller.styleSheet.tableCellPadding,
        tableColumnWidth: controller.styleSheet.tableColumnWidth,
      ),
      ImageBuilder(),
      CodeBlockBuilder(
        controller: controller,
        context: context,
        textStyle: controller.styleSheet.codeBlock,
        padding: controller.styleSheet.codeblockPadding,
        decoration: controller.styleSheet.codeblockDecoration,
      ),
      BlockquoteBuilder(
        context: context,
        textStyle: controller.styleSheet.blockquote,
        decoration: controller.styleSheet.blockquoteDecoration,
        padding: controller.styleSheet.blockquotePadding,
        contentPadding: controller.styleSheet.blockquoteContentPadding,
      ),
      ListBuilder(
        controller: controller,
        list: controller.styleSheet.list,
        listItem: controller.styleSheet.listItem,
        listItemMinIndent: controller.styleSheet.listItemMinIndent,
        checkbox: controller.styleSheet.checkbox,
        paragraphPadding: controller.styleSheet.paragraphPadding,
      ),
      FootnoteBuilder(
        footnote: controller.styleSheet.footnote,
        footnoteReference: controller.styleSheet.footnoteReference,
        footnoteReferenceDecoration:
            controller.styleSheet.footnoteReferenceDecoration,
        footnoteReferencePadding:
            controller.styleSheet.footnoteReferencePadding,
      ),
    ];

    for (final builder in [...defaultBuilders, ...controller.elementBuilders]) {
      for (final type in builder.matchTypes) {
        _builders[type] = builder..register(this);
      }
    }
  }

  final TextAlign _textAlign;
  final SelectionRegistrar? _selectionRegistrar;
  final TextStyle _defaultTextStyle;
  final MarkDownController controller;
  bool get selectable => _selectionRegistrar != null;
  MouseCursor? get mouseCursor => selectable ? SystemMouseCursors.text : null;

  String? _keepLineEndingsWhen;
  final _gestureRecognizers = <String, GestureRecognizer>{};

  final _tree = <_TreeElement>[];
  final _builders = <String, MarkdownElementBuilder>{};

  List<Widget> render(List<MdNode> nodes) {
    _tree.clear();
    _keepLineEndingsWhen = null;
    _gestureRecognizers.clear();

    final rootChildren = <MarkdownNode>[];
    _tree.add(_TreeElement.root(rootChildren));

    for (final MarkdownNode node in AstTransformer().transform(nodes)) {
      assert(_tree.length == 1);
      rootChildren.add(node);
      node.accept(this);
    }

    assert(_keepLineEndingsWhen == null);
    assert(_gestureRecognizers.isEmpty);
    return _tree.single.children;
  }

  @override
  bool visitElementBefore(MarkdownElement element) {
    final type = element.type;
    assert(_builders[type] != null, "No $type builder found");

    final parentTreeElement = _tree.last;
    final builder = _builders[type]!;
    builder.init(element);

    builder.parentStyle = parentTreeElement.style;
    if (builder.replaceLineEndings(type) == false) {
      _keepLineEndingsWhen = type;
    }
    _gestureRecognizers.addIfNotNull(
      type,
      builder.gestureRecognizer(element),
    );

    final defaultTextStyle =
        _defaultTextStyle.merge(controller.styleSheet.textStyle);

    _tree.add(_TreeElement.fromAstElement(
      element,
      style: builder.buildTextStyle(element, defaultTextStyle),
    ));
    return true;
  }

  @override
  void visitText(MarkdownText text) {
    final parent = _tree.last;
    final builder = _builders[parent.type]!;
    final textContent = _keepLineEndingsWhen == null
        ? text.text.replaceAll('\n', ' ')
        : text.text;
    var textSpan = builder.buildText(textContent, parent);

    if (_gestureRecognizers.isNotEmpty) {
      textSpan = TextSpan(
        text: textSpan.text,
        children: textSpan.children,
        semanticsLabel: textSpan.semanticsLabel,
        style: textSpan.style,
        mouseCursor: SystemMouseCursors.click,
        recognizer: _gestureRecognizers.entries.last.value,
      );
    }

    parent.children.add(createRichText(
      textSpan,
      textAlign: builder.textAlign(parent),
    ));
  }

  @override
  void visitElementAfter(MarkdownElement element) {
    final current = _tree.removeLast();
    final type = current.type;
    final parent = _tree.last;
    final builder = _builders[type]!;

    final textSpan = builder.createText(current, parent.style);
    if (textSpan != null) {
      current.children.add(createRichText(textSpan));
    }

    current.children.replaceRange(
      0,
      current.children.length,
      compressWidgets(current.children),
    );

    final widget = builder.buildWidget(current, parent);
    final isBlock = builder.isBlock(current);
    if (widget != null) {
      if (widget is InlineWraper) {
        parent.children.addAll(widget.children);
      } else {
        if (!isBlock) {
          _checkInlineWidget(widget);
        }

        parent.children.add(widget);
      }
    }

    if (_keepLineEndingsWhen == type) {
      _keepLineEndingsWhen = null;
    }

    _gestureRecognizers.remove(type);
  }

  /// Creates a [RichText] widget.
  Widget createRichText(
    TextSpan text, {
    TextAlign? textAlign,
    StrutStyle? strutStyle,
  }) {
    return RichText(
        strutStyle: strutStyle,
        text: text,
        textAlign: textAlign ?? _textAlign,
        selectionColor: controller.selectionColor,
        selectionRegistrar: _selectionRegistrar);
  }

  /// Merges the [RichText] elements of [widgets] while it is possible.
  List<Widget> compressWidgets(List<Widget> widgets) => mergeRichText(
        widgets,
        richTextBuilder: (span, textAlign) => createRichText(
          span,
          textAlign: textAlign,
        ),
      );
}

class _TreeElement extends MarkdownTreeElement {
  _TreeElement.root(List<MarkdownNode> children)
      : super(
          element: MarkdownElement.root(children),
          style: null,
        );

  _TreeElement.fromAstElement(MarkdownElement element, {TextStyle? style})
      : super(
          element: element,
          style: style,
        );
}

void _checkInlineWidget(Widget widget) {
  final allowedInlineWidgets = [
    RichText,
    Text,
    DefaultTextStyle,
  ];

  assert(
    allowedInlineWidgets.contains(widget.runtimeType),
    'It is not allowed to return ${widget.runtimeType} from BuildWidget'
    ' when it is not a block widget. The allowed types:'
    '$allowedInlineWidgets',
  );
}

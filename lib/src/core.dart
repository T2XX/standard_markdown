import 'dart:async';

import 'package:dart_markdown/dart_markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../global_coltroller.dart';
import 'renderer.dart';
import 'toolbar/toolbar.dart';

int textIndex = 0;
Timer? timer;
final FocusNode _focusNode = FocusNode();
Rx<Offset> position = Offset(0, 0).obs;
List<String> textStates = []; /* redo undo */

void changePosition(dx, dy) => position.value = Offset(dx, dy);
final MarkDownConfig config = Get.put(MarkDownConfig());

class StandardMarkdown extends StatefulWidget {
  const StandardMarkdown(
      {super.key,
      required this.oninit,
      required this.data,
      required this.mode,
      required this.selectable,
      this.toolbarPosition,
      required this.toolbar});
  final bool toolbar;

  final Function(MarkDownConfig config) oninit;
  final TextEditingController data;
  final bool selectable;
  final int mode;
  final Offset? toolbarPosition;

  @override
  State<StandardMarkdown> createState() => _StandardmarkdownState();
}

class _StandardmarkdownState extends State<StandardMarkdown> {
  @override
  void initState() {
    position.value = widget.toolbarPosition ?? Offset(0, 0);
    textStates.add(widget.data.text);
    widget.oninit(config); /* init user's config */
    super.initState();
  }

  @override
  void dispose() {
    textStates = [];
    textIndex = 0;
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        SelectionArea(
            child: Builder(
                builder: (context) => widget.mode == 0
                    ? Row(children: [
                        SizedBox(
                            width: constraints.maxWidth * 0.5,
                            child: config.textdirection == TextDirection.ltr
                                ? _buildSvEditArea(widget.data)
                                : _buildMarkdown(
                                    context,
                                    widget.selectable
                                        ? SelectionContainer.maybeOf(context)
                                        : null)),
                        Expanded(
                            child: config.textdirection == TextDirection.ltr
                                ? _buildMarkdown(
                                    context,
                                    widget.selectable
                                        ? SelectionContainer.maybeOf(context)
                                        : null)
                                : _buildSvEditArea(widget.data))
                      ])
                    : _buildMarkdown(
                        context,
                        widget.selectable
                            ? SelectionContainer.maybeOf(context)
                            : null))),
        if (widget.toolbar)
          Obx(() => Positioned(
              right: position.value.dx,
              bottom: position.value.dy,
              child: Draggable(
                  onDragEnd: (details) => changePosition(
                      constraints.maxWidth - details.offset.dx - 240,
                      constraints.maxHeight - details.offset.dy - 106),
                  childWhenDragging: SizedBox(),
                  feedback:
                      MarkdownToolbar(data: widget.data, focusNode: _focusNode),
                  child: MarkdownToolbar(
                      data: widget.data, focusNode: _focusNode))))
      ]);
    });
  }

  Widget _buildSvEditArea(TextEditingController data) {
    final MarkDownConfig controller = Get.put(MarkDownConfig());
    return Focus(
        onKey: (node, event) {
          if (event is RawKeyDownEvent && event.logicalKey.keyLabel == 'Tab') {
            /* tab插入四个空格*/
            final int origin = data.selection.baseOffset + 4;
            data.text =
                "${data.text.substring(0, data.selection.baseOffset)}    ${data.text.substring(data.selection.baseOffset)}";
            data.selection =
                TextSelection.fromPosition(TextPosition(offset: origin));
            return KeyEventResult.handled;
          } else {
            return KeyEventResult.ignored;
          }
        },
        child: TextField(
            controller: data,
            focusNode: _focusNode,
            autofocus: true,
            onChanged: (value) {
              timer?.cancel();
              timer = Timer(
                  const Duration(milliseconds: 500),
                  () => setState(() {
                        if (textIndex < textStates.length - 1) {
                          textStates = textStates.sublist(0, textIndex + 1);
                        }
                        textStates.add(value);
                        textIndex++;
                      }));
            },
            textInputAction: TextInputAction.newline,
            style: const TextStyle(textBaseline: TextBaseline.alphabetic),
            decoration: InputDecoration(
                border: InputBorder.none, hintText: controller.svEditHint),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            expands: true,
            textDirection: controller.textdirection));
  }

  ListView _buildMarkdown(
      BuildContext context, SelectionRegistrar? selectionRegistrar) {
    final MarkDownConfig controller = Get.put(MarkDownConfig());

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
        controller: controller,
        selectionRegistrar: selectionRegistrar);

    List<md.Node> astNodes;
    astNodes = markdown.parse(widget.data.text);

    try {
      astNodes = markdown.parse(widget.data.text);
      if (controller.nodesFilter != null) {
        astNodes = controller.nodesFilter!(astNodes);
      }
    } catch (_) {
      // Render the entire text as a paragraph if parse fails.
      final textNode = md.Text.fromString(widget.data.text);
      astNodes = [
        md.BlockElement('paragraph',
            start: textNode.start, end: textNode.end, children: [textNode]),
      ];
    }

    return ListView(children: renderer.render(astNodes));
  }
}

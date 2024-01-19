import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_coltroller.dart';
import '../../standard_markdown.dart';

class MarkdownToolbar extends StatefulWidget {
  const MarkdownToolbar(
      {super.key, required this.data, required this.focusNode});
  final TextEditingController data;
  final FocusNode focusNode;

  @override
  State<MarkdownToolbar> createState() => _MarkdownToolbarState();
}

class _MarkdownToolbarState extends State<MarkdownToolbar> {
  @override
  Widget build(BuildContext context) {
    final MarkDownConfig controller = Get.put(MarkDownConfig());

    return Container(
        decoration: controller.toolbarDecoration,
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H1", widget.focusNode),
                  icon: Text("H1")),
              IconButton(
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H2", widget.focusNode),
                  icon: Text("H2")),
              IconButton(
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H3", widget.focusNode),
                  icon: Text("H3")),
              IconButton(
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H4", widget.focusNode),
                  icon: Text("H4")),
              IconButton(
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H5", widget.focusNode),
                  icon: Text("H5")),
              IconButton(
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H6", widget.focusNode),
                  icon: Text("H6"))
            ],
          ),
          Row(children: [
            IconButton(
                tooltip: controller.toolbarBoldTooltip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Bold", widget.focusNode),
                icon: Text("B",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            IconButton(
                tooltip: controller.toolbarItalicTooltip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Italic", widget.focusNode),
                icon: Text("I",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 18))),
            IconButton(
                tooltip: controller.toolbarDelTooltip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Del", widget.focusNode),
                icon: Text("T",
                    style: TextStyle(decoration: TextDecoration.lineThrough))),
            IconButton(
                tooltip: controller.toolbarLinkTooltip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Link", widget.focusNode),
                icon: Icon(Icons.link)),
            IconButton(
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Check", widget.focusNode),
                icon: Icon(Icons.check_box_outline_blank)),
            IconButton(
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Uncheck", widget.focusNode),
                icon: Icon(Icons.check_box)),
          ]),
          Row(children: [
            IconButton(
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Photo", widget.focusNode),
                icon: Icon(Icons.photo)),
            IconButton(
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Code", widget.focusNode),
                icon: Icon(Icons.code)),
            IconButton(
                onPressed: () => controller.toolbarFormat(
                    widget.data, "BulletList", widget.focusNode),
                icon: Icon(Icons.format_list_bulleted)),
            IconButton(
                onPressed: () => controller.toolbarFormat(
                    widget.data, "NumbertList", widget.focusNode),
                icon: Icon(Icons.format_list_numbered)),
            IconButton(onPressed: () {}, icon: Icon(Icons.format_quote)),
            IconButton(onPressed: () {}, icon: Icon(Icons.horizontal_rule)),
          ]),
          Row(
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        if (textIndex > 0) {
                          textIndex--;
                          widget.data.text = textStates[textIndex];
                        }
                      }),
                  icon: Icon(Icons.undo)),
              IconButton(
                  onPressed: () => setState(() {
                        if (textIndex < textStates.length - 1) {
                          textIndex++;
                          widget.data.text = textStates[textIndex];
                        }
                      }),
                  icon: Icon(Icons.redo)),
              IconButton(
                  onPressed: () =>
                      setState(() => controller.formate(widget.data)),
                  icon: Icon(Icons.text_format)),
            ],
          )
        ]));
  }
}

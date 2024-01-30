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
          Wrap(
            children: [
              IconButton(
                  tooltip: controller.toolbarH1Tip,
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H1", widget.focusNode),
                  icon: Text("H1")),
              IconButton(
                  tooltip: controller.toolbarH2Tip,
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H2", widget.focusNode),
                  icon: Text("H2")),
              IconButton(
                  tooltip: controller.toolbarH3Tip,
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H3", widget.focusNode),
                  icon: Text("H3")),
              IconButton(
                  tooltip: controller.toolbarH4Tip,
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H4", widget.focusNode),
                  icon: Text("H4")),
              IconButton(
                  tooltip: controller.toolbarH5Tip,
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H5", widget.focusNode),
                  icon: Text("H5")),
              IconButton(
                  tooltip: controller.toolbarH6Tip,
                  onPressed: () => controller.toolbarFormat(
                      widget.data, "H6", widget.focusNode),
                  icon: Text("H6"))
            ],
          ),
          Wrap(children: [
            IconButton(
                tooltip: controller.toolbarBoldTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Bold", widget.focusNode),
                icon: Text("B",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            IconButton(
                tooltip: controller.toolbarItalicTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Italic", widget.focusNode),
                icon: Text("I",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 18))),
            IconButton(
                tooltip: controller.toolbarDelTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Del", widget.focusNode),
                icon: Text("T",
                    style: TextStyle(decoration: TextDecoration.lineThrough))),
            IconButton(
                tooltip: controller.toolbarLinkTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Link", widget.focusNode),
                icon: Icon(Icons.link)),
            IconButton(
                tooltip: controller.toolbarUnCheckBoxTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Check", widget.focusNode),
                icon: Icon(Icons.check_box_outline_blank)),
            IconButton(
                tooltip: controller.toolbarCheckBoxTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Uncheck", widget.focusNode),
                icon: Icon(Icons.check_box)),
          ]),
          Wrap(children: [
            IconButton(
                tooltip: controller.toolbarPhotoTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Photo", widget.focusNode),
                icon: Icon(Icons.photo)),
            IconButton(
                tooltip: controller.toolbarCodeBlockTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Code", widget.focusNode),
                icon: Icon(Icons.code)),
            IconButton(
                tooltip: controller.toolbarBulletListTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "BulletList", widget.focusNode),
                icon: Icon(Icons.format_list_bulleted)),
            IconButton(
                tooltip: controller.toolbarNumbertListTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "NumbertList", widget.focusNode),
                icon: Icon(Icons.format_list_numbered)),
            IconButton(
                tooltip: controller.toolbarQuoteTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Quote", widget.focusNode),
                icon: Icon(Icons.format_quote)),
            IconButton(
                tooltip: controller.toolbarDividerTip,
                onPressed: () => controller.toolbarFormat(
                    widget.data, "Divider", widget.focusNode),
                icon: Icon(Icons.horizontal_rule)),
          ]),
          Wrap(
            children: [
              IconButton(
                  onPressed: () {
                    if (textIndex > 0) {
                      textIndex--;
                      widget.data.text = textStates[textIndex];
                    }
                  },
                  icon: Icon(Icons.undo)),
              IconButton(
                  onPressed: () {
                    if (textIndex < textStates.length - 1) {
                      textIndex++;
                      widget.data.text = textStates[textIndex];
                    }
                  },
                  icon: Icon(Icons.redo)),
              IconButton(
                  onPressed: () =>
                      setState(() => controller.formate(widget.data)),
                  icon: Icon(Icons.text_format))
            ],
          )
        ]));
  }
}

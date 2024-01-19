import 'package:flutter/material.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class FootnoteBuilder extends MarkdownElementBuilder {
  FootnoteBuilder(this.controller)
      : super(
            textStyleMap: {'footnoteReference': controller.footnoteReference});
  MarkDownConfig controller;

  @override
  final matchTypes = ['footnote', 'footnoteReference'];

  @override
  Widget? buildWidget(element, parent) {
    if (element.type == 'footnote') {
      return Text(element.attributes['number']!,
          style: controller.footNoteStyle);
    }
    final child = element.children.single;
    if (controller.footnoteReferenceDecoration == null &&
        controller.footnoteReferencePadding == null) {
      return child;
    }

    return Container(
        decoration: controller.footnoteReferenceDecoration,
        padding: controller.footnoteReferencePadding,
        child: child);
  }
}

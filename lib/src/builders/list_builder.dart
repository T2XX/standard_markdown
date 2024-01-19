import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_coltroller.dart';
import '../ast.dart';
import 'builder.dart';

/// A builder to create list.
class ListBuilder extends MarkdownElementBuilder {
  ListBuilder(this.controller)
      : super(textStyleMap: {
          'orderedList': controller.orderedListTextStyle,
          'bulletList': controller.bulletListTextStyle,
          'listItem': controller.listItemTextStyle
        });
  final MarkDownConfig controller;

  @override
  final matchTypes = ['orderedList', 'bulletList', 'listItem'];

  final _listStrack = <MarkdownElement>[];

  bool _isList(String type) => type == 'orderedList' || type == 'bulletList';

  @override
  void init(element) {
    final type = element.type;
    if (_isList(type)) {
      _listStrack.add(element);
    }
  }

  @override
  Widget? buildWidget(element, parent) {
    final type = element.type;
    final child = super.buildWidget(element, parent);
    if (_isList(type)) {
      _listStrack.removeLast();
      return child;
    }

    final itemMarker = element.attributes['taskListItem'] == null
        ? _buildListItemMarker(
            _listStrack.last.type,
            element.attributes['number'],
            element.style,
          )
        : _buildCheckbox(
            element.attributes['taskListItem'] == 'checked',
            element.style,
          );

    final markerContainerHeight = _getLineHeight(element.style);

    final listItem =
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: markerContainerHeight ?? 0.0,
              maxHeight: markerContainerHeight ?? double.infinity,
              minWidth: controller.listItemMinIndent),
          child: Align(
            child: Padding(
                padding: EdgeInsets.only(
                    right: controller.listItemMarkerTrailingSpace),
                child: itemMarker),
          )),
      if (child != null) Expanded(child: child)
    ]);

    if (_listStrack.last.attributes['isTight'] == 'true') {
      return listItem;
    }

    return Padding(padding: controller.paragraphPadding, child: listItem);
  }

  Widget _buildListItemMarker(
    String type,
    String? number,
    TextStyle? listItemStyle,
  ) {
    final listType = type == 'bulletList'
        ? MarkdownListType.unordered
        : MarkdownListType.ordered;
    return controller.markdownListItemMarkerBuilder(
        listType, number, listItemStyle!);
  }

  Widget _buildCheckbox(bool checked, TextStyle? listItemStyle) {
    final RxBool check = checked.obs;
    return Obx(() => GestureDetector(
          onTap: () {
            check.value = !check.value;
          },
          child: Icon(check.value
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank),
        ));
  }

  double? _getLineHeight(TextStyle? style) {
    if (style == null || style.fontSize == null) {
      return null;
    }

    return style.fontSize! * (style.height ?? 1);
  }
}

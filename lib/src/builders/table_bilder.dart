import 'package:flutter/material.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class TableBuilder extends MarkdownElementBuilder {
  TableBuilder(this.controller);

  MarkDownConfig controller;

  final _tableStack = <_TableElement>[];

  @override
  final matchTypes = [
    'table',
    'tableHead',
    'tableRow',
    'tableBody',
    'tableHeadCell',
    'tableBodyCell'
  ];

  @override
  bool isBlock(element) => element.type == 'table';

  @override
  void init(element) {
    final type = element.type;
    if (type == 'table') {
      _tableStack.add(_TableElement());
    } else if (type == 'tableRow') {
      var decoration = controller.tableRowDecoration;
      final alternating = controller.tableRowDecorationAlternating;
      if (alternating != null) {
        final length = _tableStack.single.rows.length;
        if (alternating == MarkdownAlternating.odd) {
          decoration = length.isOdd ? null : decoration;
        } else {
          decoration = length.isOdd ? decoration : null;
        }
      }

      _tableStack.single.rows
          .add(TableRow(decoration: decoration, children: []));
    }
  }

  @override
  TextAlign? textAlign(parent) {
    TextAlign? textAlign;
    if (parent.type == 'tableHeadCell' || parent.type == 'tableBodyCell') {
      textAlign = {
        'left': TextAlign.left,
        'right': TextAlign.right,
        'center': TextAlign.center,
      }[parent.attributes['textAlign']];
    }
    return textAlign;
  }

  @override
  Widget? buildWidget(element, parent) {
    final type = element.type;

    if (type == 'table') {
      final ScrollController tableScroll = ScrollController();

      return Scrollbar(
          controller: tableScroll,
          child: SingleChildScrollView(
              controller: tableScroll,
              scrollDirection: Axis.horizontal,
              child: Table(
                  defaultColumnWidth: controller.tableColumnWidth,
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: controller.tableBorder,
                  children: _tableStack.removeLast().rows)));
    } else if (type == 'tableHeadCell' || type == 'tableBodyCell') {
      final children = element.children;

      _tableStack.single.rows.last.children.add(TableCell(
        verticalAlignment: TableCellVerticalAlignment.top,
        child: Padding(
            padding: controller.tableCellPadding,
            child:
                children.isEmpty ? const SizedBox.shrink() : children.single),
      ));
    }
    return null;
  }
}

class _TableElement {
  final List<TableRow> rows = <TableRow>[];
}

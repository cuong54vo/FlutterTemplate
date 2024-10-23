import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class DecoratedTablePage extends StatelessWidget {
  const DecoratedTablePage({
    Key? key,
    this.data = const [],
    this.titleColumn = const [],
    this.titleRow = const [],
  }) : super(key: key);

  final List<List<String>> data;
  final List<String> titleColumn;
  final List<String> titleRow;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sticky Headers Two-Dimension Table Decorated',
          maxLines: 2,
        ),
        backgroundColor: Colors.amber,
      ),
      body: StickyHeadersTable(
        columnsLength: titleColumn.length,
        rowsLength: titleRow.length,
        columnsTitleBuilder: (i) => TableCell.stickyRow(
          titleColumn[i],
          textStyle: textTheme.labelLarge?.copyWith(fontSize: 15.0),
        ),
        rowsTitleBuilder: (i) => TableCell.stickyColumn(
          titleRow[i],
          textStyle: textTheme.labelLarge?.copyWith(fontSize: 15.0),
        ),
        contentCellBuilder: (i, j) => TableCell.content(
          data[i][j],
          textStyle: textTheme.bodyMedium?.copyWith(fontSize: 12.0),
        ),
        legendCell: TableCell.legend(
          'Sticky Legend',
          textStyle: textTheme.labelLarge?.copyWith(fontSize: 16.5),
        ),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  TableCell.content(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth ?? 0,
        cellHeight = cellDimensions.contentCellHeight ?? 0,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.legend(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth ?? 0,
        cellHeight = cellDimensions.stickyLegendHeight ?? 0,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  TableCell.stickyRow(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.amber,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth ?? 0,
        cellHeight = cellDimensions.stickyLegendHeight ?? 0,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.amber,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCell.stickyColumn(
    this.text, {
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth ?? 0,
        cellHeight = cellDimensions.contentCellHeight ?? 0,
        _colorHorizontalBorder = Colors.amber,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.start,
        _padding = EdgeInsets.only(left: 24.0);

  final CellDimensions cellDimensions;
  final String text;
  final Function()? onTap;
  final double cellWidth;
  final double cellHeight;
  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;
  final TextAlign _textAlign;
  final EdgeInsets _padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth,
        height: cellHeight,
        padding: _padding,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  text,
                  style: textStyle,
                  maxLines: 2,
                  textAlign: _textAlign,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.1,
              color: _colorVerticalBorder,
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: _colorHorizontalBorder),
            right: BorderSide(color: _colorHorizontalBorder),
          ),
          color: colorBg,
        ),
      ),
    );
  }
}

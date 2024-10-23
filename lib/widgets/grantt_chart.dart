import 'package:flutter/material.dart';
import 'dart:math';

class GanttChartScreen extends StatefulWidget {
  const GanttChartScreen({
    Key? key,
    required this.itemListInChart,
    required this.itemListDataInChart,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  final List<ItemList> itemListInChart;
  final List<ItemListData> itemListDataInChart;
  final DateTime fromDate;
  final DateTime toDate;

  @override
  State<StatefulWidget> createState() => GanttChartScreenState();
}

class GanttChartScreenState extends State<GanttChartScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GanttChart(
            animationController: animationController,
            fromDate: widget.fromDate,
            toDate: widget.toDate,
            data: widget.itemListDataInChart,
            itemListInChart: widget.itemListInChart,
          ),
        ),
      ],
    );
  }
}

class GanttChart extends StatelessWidget {
  final AnimationController animationController;
  final DateTime fromDate;
  final DateTime toDate;
  final List<ItemListData> data;
  final List<ItemList> itemListInChart;

  late int viewRange;
  int viewRangeToFitScreen = 6;

  GanttChart({
    required this.animationController,
    required this.fromDate,
    required this.toDate,
    required this.data,
    required this.itemListInChart,
  }) {
    viewRange = calculateNumberOfMonthsBetween(fromDate, toDate);
  }

  Color randomColorGenerator() {
    var r = Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  int calculateNumberOfMonthsBetween(DateTime from, DateTime to) {
    return to.month - from.month + 12 * (to.year - from.year) + 1;
  }

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    }
    return calculateNumberOfMonthsBetween(fromDate, projectStartedAt) - 1;
  }

  int calculateRemainingWidth(DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength = calculateNumberOfMonthsBetween(projectStartedAt, projectEndedAt);
    if (projectStartedAt.isAfter(fromDate) && projectStartedAt.isBefore(toDate)) {
      return projectLength <= viewRange ? projectLength : viewRange - calculateNumberOfMonthsBetween(fromDate, projectStartedAt);
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isBefore(toDate)) {
      return projectLength - calculateNumberOfMonthsBetween(projectStartedAt, fromDate);
    } else if (projectStartedAt.isBefore(fromDate) && projectEndedAt.isAfter(toDate)) {
      return viewRange;
    }
    return 0;
  }

  List<Widget> buildChartBars(List<ItemListData> data, double chartViewWidth, Color color) {
    List<Widget> chartBars = [];

    for (var item in data) {
      var remainingWidth = calculateRemainingWidth(item.startTime, item.endTime);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
            color: color.withAlpha(100),
            borderRadius: BorderRadius.circular(5.0),
          ),
          height: 25.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
            left: calculateDistanceToLeftBorder(item.startTime) * chartViewWidth / viewRangeToFitScreen,
            top: chartBars.isEmpty ? 4.0 : 2.0,
            bottom: chartBars.isEmpty ? 4.0 : 2.0,
          ),
          alignment: Alignment.centerLeft,
        ));
      }
    }

    return chartBars;
  }

  Widget buildHeader(double chartViewWidth, Color color) {
    List<Widget> headerItems = [];
    DateTime tempDate = fromDate;

    headerItems.add(Container(
      width: chartViewWidth / viewRangeToFitScreen,
      child: const Text(
        '',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10.0),
      ),
    ));

    for (int i = 0; i < viewRange; i++) {
      headerItems.add(Container(
        width: chartViewWidth / viewRangeToFitScreen,
        child: Text(
          '${tempDate.month}/${tempDate.year}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10.0),
        ),
      ));
      tempDate = DateTime(tempDate.year, tempDate.month + 1, tempDate.day);
    }

    return Container(
      height: 25.0,
      color: color.withAlpha(100),
      child: Row(children: headerItems),
    );
  }

  Widget buildGrid(double chartViewWidth) {
    List<Widget> gridColumns = [];
    for (int i = 0; i <= viewRange; i++) {
      gridColumns.add(Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.withAlpha(100), width: 1.0),
          ),
        ),
        width: chartViewWidth / viewRangeToFitScreen,
      ));
    }

    return Row(children: gridColumns);
  }

  Widget buildChartForEachUser(List<ItemListData> itemListDataInChart, double chartViewWidth, ItemList user) {
    Color color = randomColorGenerator();
    var chartBars = buildChartBars(itemListDataInChart, chartViewWidth, color);
    return Container(
      height: chartBars.length * 29.0 + 25.0 + 4.0 + 30,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Stack(
            fit: StackFit.loose,
            children: <Widget>[
              buildGrid(chartViewWidth),
              buildHeader(chartViewWidth, color),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: chartViewWidth / viewRangeToFitScreen,
                      height: chartBars.length * 29.0 + 4.0 + 30,
                      color: color.withAlpha(100),
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: chartBars.length * 29.0 + 4.0 > 50 ? 0 : 0,
                          child: Text(
                            user.name,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: chartBars),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> buildChartContent(double chartViewWidth) {
    List<Widget> chartContent = [];
    for (var user in itemListInChart) {
      List<ItemListData> projectsOfUser = data.where((project) => project.itemListId.contains(user.id)).toList();
      if (projectsOfUser.isNotEmpty) {
        chartContent.add(buildChartForEachUser(projectsOfUser, chartViewWidth, user));
      }
    }
    return chartContent;
  }

  @override
  Widget build(BuildContext context) {
    var chartViewWidth = MediaQuery.of(context).size.width;
    var screenOrientation = MediaQuery.of(context).orientation;

    viewRangeToFitScreen = screenOrientation == Orientation.landscape ? 12 : 6;

    return Container(
      child: MediaQuery.removePadding(
        child: ListView(children: buildChartContent(chartViewWidth)),
        removeTop: true,
        context: context,
      ),
    );
  }
}

class ItemList {
  final int id;
  final String name;
  ItemList({required this.id, required this.name});
}

class ItemListData {
  final int id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final List<int> itemListId;
  ItemListData({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.itemListId,
  });
}

// Sample data
final itemList = [
  ItemList(id: 1, name: 'Steve'),
  ItemList(id: 2, name: 'Leila'),
  ItemList(id: 3, name: 'Alex'),
  ItemList(id: 4, name: 'Ryan'),
];

final itemListData = [
  ItemListData(
    id: 1,
    name: 'Steve',
    startTime: DateTime(2017, 3, 2),
    endTime: DateTime(2018, 6, 10),
    itemListId: [1],
  ),
  ItemListData(
    id: 2,
    name: 'Leila',
    startTime: DateTime(2018, 4, 1),
    endTime: DateTime(2018, 6, 1),
    itemListId: [2],
  ),
  ItemListData(
    id: 3,
    name: 'Alex',
    startTime: DateTime(2017, 5, 1),
    endTime: DateTime(2018, 9, 1),
    itemListId: [3],
  ),
  ItemListData(
    id: 4,
    name: 'Ryan',
    startTime: DateTime(2018, 6, 1),
    endTime: DateTime(2018, 10, 1),
    itemListId: [4],
  ),
];

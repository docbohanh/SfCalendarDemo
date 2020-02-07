import 'package:calendar_test/model/model.dart';
import 'package:calendar_test/sfChart/charts.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class SchedulePage extends StatefulWidget {
  SchedulePage({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _SchedulePageState createState() => _SchedulePageState(sample);
}

class _SchedulePageState extends State<SchedulePage> {
  _SchedulePageState(this.sample);

  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lịch công tác',
        ),
      ),
      body: getRangeColumnWithTrack(false),
    );
  }
}

SfCartesianChart getRangeColumnWithTrack(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isTileView ? '' : 'Meeting timings of an employee'),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
    ),
    primaryYAxis: NumericAxis(
      axisLine: AxisLine(width: 0),
      minimum: 1,
      maximum: 10,
      labelFormat: '{value} PM',
      majorTickLines: MajorTickLines(size: 0),
    ),
    series: getRangeColumnSeriesWithTrack(isTileView),
    tooltipBehavior: TooltipBehavior(
      enable: true,
      canShowMarker: false,
      header: '',
    ),
  );
}

List<RangeColumnSeries<ChartSampleData, String>> getRangeColumnSeriesWithTrack(
    bool isTileView) {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Thứ 2', y: 3, yValue: 5, text: 'Giao ban'),
    ChartSampleData(x: 'Thứ 3', y: 4, yValue: 7, text: 'Họp đầu tuần'),
    ChartSampleData(x: 'Thứ 4', y: 4, yValue: 8, text: 'Họp triển khai'),
    ChartSampleData(x: 'Thứ 5', y: 2, yValue: 5, text: 'Họp'),
    ChartSampleData(x: 'Thứ 6', y: 5, yValue: 7, text: 'Họp nữa'),
    ChartSampleData(x: 'Thứ 7', y: 7, yValue: 9, text: 'Lại họp'),
  ];
  return <RangeColumnSeries<ChartSampleData, String>>[
    RangeColumnSeries<ChartSampleData, String>(
      enableTooltip: true,
      dataSource: chartData,
      isTrackVisible: true,
      trackColor: const Color.fromRGBO(198, 201, 207, 1),
      borderRadius: BorderRadius.circular(3),
      trackBorderColor: Colors.grey[100],
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      lowValueMapper: (ChartSampleData sales, _) => sales.y,
      highValueMapper: (ChartSampleData sales, _) => sales.yValue,
      dataLabelSettings: DataLabelSettings(
        isVisible: !isTileView,
        labelAlignment: ChartDataLabelAlignment.top,
      ),
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:fuzzy_search/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          header: '',
          format: 'point.y matches of Score point.x'),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0), minimum: 0),
      series:  <ColumnSeries<ResultData, num>>[
        ColumnSeries<ResultData, num>(
            enableTooltip: true,
            color: Colors.white,
            gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey,Style.secondryColor.withOpacity(0.5)]),
            width: 0.5,
            dataSource: [ResultData(80, 156),ResultData(90, 36),ResultData(100, 56)],
            xValueMapper: (ResultData sales, _) => sales.score,
            yValueMapper: (ResultData sales, _) => sales.count)
      ],
    );
  }
}
class ResultData {
  ResultData(this.score, this.count);
  final int score;
  final int count;
}

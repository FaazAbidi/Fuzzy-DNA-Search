import 'package:flutter/material.dart';
import 'package:fuzzy_search/result_graph_data.dart';
import 'package:fuzzy_search/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  final List<ResultGraphData> resultGraphData;
  const Graph({Key key, this.resultGraphData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          header: '',
          format: 'point.y matches of score point.x'),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0), minimum: 0),
      series:  <ColumnSeries<ResultGraphData, num>>[
        ColumnSeries<ResultGraphData, num>(
            enableTooltip: true,
            gradient: LinearGradient(
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: [Style.secondryColor.withOpacity(0.5),Style.secondryColor.withOpacity(1)]),
            width: 0.5,
            dataSource: resultGraphData,
            xValueMapper: (ResultGraphData sales, _) => sales.score,
            yValueMapper: (ResultGraphData sales, _) => sales.count)
      ],
    );
  }
}

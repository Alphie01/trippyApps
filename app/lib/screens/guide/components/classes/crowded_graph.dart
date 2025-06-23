import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';

class CrowdedGraph extends StatefulWidget {
  const CrowdedGraph({super.key});

  @override
  State<CrowdedGraph> createState() => _CrowdedGraphState();
}

class _CrowdedGraphState extends State<CrowdedGraph> {
  List<Color> gradientColors = [
    AppTheme.textColor,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = AppText(text: '00:00');
        break;
      case 4:
        text = AppText(text: '04:00');
        break;
      case 8:
        text = AppText(text: '08:00');
        break;
      case 12:
        text = AppText(text: '12:00');
        break;
      case 16:
        text = AppText(text: '16:00');
        break;
      case 20:
        text = AppText(text: '20:00');
        break;
      case 24:
        text = AppText(text: '24:00');
        break;
      default:
        text = AppText(text: '');

        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 2:
        text = '%20';
        break;
      case 4:
        text = '%40';
        break;
      case 6:
        text = '%60';
        break;
      case 8:
        text = '%80';
        break;
      case 10:
        text = '%100';
        break;
      default:
        return Container();
    }

    return AppText(text: text, align: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.textColor.withOpacity(.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.textColor.withOpacity(.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 1),
            FlSpot(2, 2),
            FlSpot(3, 1),
            FlSpot(4, 2),
            FlSpot(5, 3),
            FlSpot(6, 2),
            FlSpot(7, 4),
            FlSpot(8, 5),
            FlSpot(9, 5),
            FlSpot(10, 6),
            FlSpot(11, 6),
            FlSpot(12, 3),
            FlSpot(13, 7),
            FlSpot(14, 5),
            FlSpot(15, 6),
            FlSpot(16, 7),
            FlSpot(17, 8),
            FlSpot(18, 10),
            FlSpot(19, 10),
            FlSpot(20, 7),
            FlSpot(21, 5),
            FlSpot(22, 6),
            FlSpot(23, 4),
            FlSpot(24, 3),
          ],
          isCurved: false,
          color: AppTheme.textColor,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}

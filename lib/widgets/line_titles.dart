import 'package:fl_chart/fl_chart.dart';


class LineTitles {
  static getTitleData() {
    
    return FlTitlesData(
      show: true,
      topTitles: SideTitles(showTitles: false),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return 'MON';
            case 1:
              return 'TUE';
            case 2:
              return 'WED';
            case 3:
              return 'THU';
            case 4:
              return 'FRI';
            case 5:
              return 'SAT';
            case 6:
              return 'SUN';
            default:
              return '';
          }
        },
        margin: 30,
      ),
      leftTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(
        showTitles: true,
        reservedSize: 5,
        interval: 1,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '0';
            case 1:
              return '1';
            case 2:
              return '2';
            case 3:
              return '3';
            default:
              return '';
          }
        },
        margin: 2,
      ),
    );
  }
}
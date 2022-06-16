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
            case 1:
              return 'MAN';
            case 2:
              return 'TIRS';
            case 3:
              return 'ONS';
            case 4:
              return 'TORS';
            case 5:
              return 'FRE';
            case 6:
              return 'LØR';
            case 7:
              return 'SØN';
            default:
              return '';
          }
        },
        margin: 30,
      ),
      leftTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '0';
            case 1:
              return '1';
            case 2:
              return '2';
            default:
              return '';
          }
        },
        margin: 2,
      ),
    );
  }
}
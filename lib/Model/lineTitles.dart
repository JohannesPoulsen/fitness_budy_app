import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() {
    
    return FlTitlesData(
      show: true,
      topTitles: SideTitles(showTitles: false),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 50,
        interval: 1,
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return 'MON';
            case 2:
              return 'TUE';
            case 3:
              return 'WED';
            case 4:
              return 'THU';
            case 5:
              return 'FRI';
            case 6:
              return 'SAT';
            case 7:
              return 'SUN';
            default:
              return '';
          }

        },
        margin: 2,
      ),
      leftTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );
  }
}
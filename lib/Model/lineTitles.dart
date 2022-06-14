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
        getTitles: (value) {
          //value = value * 2;
          switch (value.toInt()) {
            case 1:{
              return 'MON';
            }
            case 2:
              return 'TUE';
            case 3:
              return 'WED';
            case 4:
              return 'THU';
            case 9: 
              return 'FRI';
            case 11: 
              return 'SAT';
            case 13:
              return 'SUN';
            default:
              return '';
          }
        },
        margin: 5,
      ),
      leftTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
      /*rightTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '0';
            case 2:
              return '1';  
            case 3:
              return '1.5';
            case 5:
              return '2';
          }
          return '';
        },
        reservedSize: 40,
        margin: 24,
      ),*/
    );
  }
}
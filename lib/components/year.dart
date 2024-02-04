
import 'package:flutter/material.dart';
import 'package:service_reddit_2/components/month.dart';


class Year extends StatelessWidget {
  Year({super.key, this.date});

  final date;

  @override
  Widget build(BuildContext context) {
    final month_length = [
      31,
      29,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];

    month_length[1] = (date.year / 4.0) == (date.year / 4.0).roundToDouble() ? 29 : 28; //Set le

    List<Widget> months = <Widget>[];
    for (int i = 0; i < 12; i++) {
      DateTime month = DateTime(date.year, i+1);
      months.add(Month(date: month, month_length: month_length[i]));
    }

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,children: months,);
  }
}

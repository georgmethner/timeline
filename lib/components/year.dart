import 'package:flutter/material.dart';
import 'package:service_reddit_2/components/month.dart';
import 'package:service_reddit_2/utilities/entry_manager.dart';

class Year extends StatelessWidget {
  Year({super.key, this.date});

  final date;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EntryManager.get_year(date.year - EntryManager.birthyear),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final month_length = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
          month_length[1] =
              (date.year / 4.0) == (date.year / 4.0).roundToDouble() ? 29 : 28; //Set le

          List<Month> months = <Month>[];
          for (int i = 0; i < 12; i++) {
            DateTime month = DateTime(date.year, i + 1);
            months.add(Month(date: month, month_length: month_length[i]));
          }

          if (snapshot.data != 0) {
            final year_data = snapshot.data! as Map<String, dynamic>;
            year_data.forEach((key, value) {
              months[int.parse(key) - 1].month_data = value;
            });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: months,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const SizedBox(
          height: 10000,
        );
      },
    );
  }
}

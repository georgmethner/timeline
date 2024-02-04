import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:service_reddit_2/components/year.dart';

class ScrollCalendar extends StatelessWidget {
  ScrollCalendar({super.key});

  static T? cast<T>(x) => x is T ? x : null;

  final cur_date = DateTime.now();
  final int start_year = 2004;

  @override
  Widget build(BuildContext context) {
    final page_controller = ItemScrollController();
    final item_count = (cur_date.year - start_year) + 5;

    return Scaffold(
        body: ScrollablePositionedList.builder(
          scrollDirection: Axis.vertical,
          itemScrollController: page_controller,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            int cur_year = start_year + i;

            return Year(date: DateTime(cur_year));
            //return Text("$month_date $i");
          },
          itemCount: item_count,
        ),
        bottomNavigationBar: const BottomAppBar(
          child: Text(
            "Timeline",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          onPressed: () {
            int x = (cur_date.year - start_year);
            page_controller.jumpTo(index: x);

            //EntryManager.add_entry("Kinderarzt", DateTime(2023, 6, 15), 0);
            //EntryManager.get_year(19);
          },
          child: const Icon(Icons.add),
        ), // This
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained);
  }
}

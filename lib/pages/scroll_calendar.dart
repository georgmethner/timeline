import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:service_reddit_2/components/year.dart';

import '../utilities/entry_manager.dart';

class ScrollCalendar extends StatelessWidget {
  ScrollCalendar({super.key});

  static T? cast<T>(x) => x is T ? x : null;

  final cur_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final page_controller = FlutterListViewController();
    final item_count = (cur_date.year - EntryManager.birthyear) + 2;
    //final item_count = 1;

    return Scaffold(
        body: FlutterListView(
          scrollDirection: Axis.vertical,
          controller: page_controller,
          cacheExtent: 50,
          delegate: SliverChildBuilderDelegate(
          (context, i) {
            int cur_year = EntryManager.birthyear + i;
            return FutureBuilder(
              future: EntryManager.get_year(i),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Year(date: DateTime(cur_year));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return SizedBox(height: 10000,);
              },

            );

          },
            childCount: item_count,
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          child: Text(
            "Timeline",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          onPressed: () {
            int x = (cur_date.year - EntryManager.birthyear);
            page_controller.sliverController.jumpToIndex(x, offset: -(0.0833), offsetBasedOnBottom: true);

            //EntryManager.add_entry("Kinderarzt", DateTime(2023, 6, 15), 0);
            //EntryManager.get_year(19);
          },
          child: const Icon(Icons.add),
        ), // This
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_reddit_2/components/entry.dart';
import 'package:service_reddit_2/utilities/entry_manager.dart';

class DayDetails {
  static void showDayDetails(context, List<Entry> entries, DateTime date) {
    Size size = MediaQuery
        .of(context)
        .size;
    DateTime selectedDate = date;
    String selectedTitle = "Neuer Eintrag";

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: size.height * 0.5,
            width: size.width,
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Text("${date.day}. ${DateFormat.MMMM('de').format(date)} ${date.year}"),
                Row(children: entries,),
                const Divider(
                  thickness: 1,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Neuer Eintrag:"),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      onChanged: (String value) {
                        selectedTitle = value;
                      },
                    ),
                    CalendarDatePicker(
                      initialDate: date,
                      firstDate: DateTime(EntryManager.birthyear),
                      lastDate: DateTime.now(),
                      onDateChanged: (DateTime newDate) {
                        selectedDate = newDate;
                      }
                    ),
                    ElevatedButton(
                      onPressed: () {
                        EntryManager.add_entry(selectedTitle, selectedDate, 0);
                        Navigator.pop(context);
                      },
                      child: const Text("Eintragen"),
                    )

                  ],)
              ]),
            ),
          );
        });
  }
}

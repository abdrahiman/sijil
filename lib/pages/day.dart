import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/components/create_popup.dart';
import 'package:myapp/components/db.dart';

class Day extends StatefulWidget {
  final String dayName;
  final List records;
  final RecordDaysDB db;
  const Day(this.dayName, this.records, this.db, {super.key});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  void addRecord(Map record) {
    setState(() {
      widget.records.add(record);
      widget.db.saveData(widget.db.recordDays);
      _sortRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dayName,
        ),
      ),
      floatingActionButton: FloatingBtn(addRecord),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: widget.records.isEmpty
            ? const Center(
                child: Text("No records found"),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemCount: widget.records.length,
                itemBuilder: (context, index) {
                  return Record(widget.records[index]);
                },
              ),
      ),
    );
  }

  void _sortRecords() {
    widget.records.sort((a, b) {
      // Custom sorting function based on startTime in "HH:mm" format
      var timeA = a["startTime"];
      var timeB = b["startTime"];

      // Splitting hours and minutes and converting to integers for comparison
      var hourA = int.parse(timeA.split(":")[0]);
      var minuteA = int.parse(timeA.split(":")[1]);
      var hourB = int.parse(timeB.split(":")[0]);
      var minuteB = int.parse(timeB.split(":")[1]);

      // Comparing hours first, then minutes if hours are equal
      if (hourA != hourB) {
        return hourA.compareTo(hourB);
      } else {
        return minuteA.compareTo(minuteB);
      }
    });
  }

  Widget Record(Map record) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          SlidableAction(
            onPressed: (ctx) {},
            backgroundColor: const Color(0xFFFE4A49),
            spacing: BorderSide.strokeAlignOutside,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (ctx) {},
            backgroundColor: const Color.fromRGBO(67, 249, 85, 1),
            spacing: BorderSide.strokeAlignOutside,
            foregroundColor: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            icon: Icons.edit,
            label: 'Edite',
          ),
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 30,
                    child: Text(record["startTime"],
                        style: const TextStyle(fontSize: 11)),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 20,
                    width: 30,
                    child: Text(record["endTime"],
                        style: const TextStyle(fontSize: 11)),
                  ),
                ]),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 60,
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(244, 244, 244, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(record["name"]),
              ),
            ),
          ]),
    );
  }
}

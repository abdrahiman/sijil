import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/components/db.dart';
import 'package:myapp/pages/day.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RecordDaysDB db = RecordDaysDB();

  @override
  void initState() {
    super.initState();
    db.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "My Days",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              separatorBuilder: (ctx, i) => const SizedBox(
                height: 10,
              ),
              itemCount: db.recordDays.length,
              shrinkWrap: true,
              itemBuilder: (ctx, idx) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Day(
                                DateFormat('EEEE dd, MMMM').format(
                                    DateTime.parse(db.recordDays[idx]["name"])),
                                db.recordDays[idx]["records"],
                                db)));
                  },
                  child: Container(
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
                    child: Text(
                      DateFormat('EEEE dd, MMMM')
                          .format(DateTime.parse(db.recordDays[idx]["name"])),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

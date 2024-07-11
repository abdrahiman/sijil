import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class RecordDaysDB {
  List recordDays = [];
  final box = Hive.box('blackbox');

  loadData() {
    var data = box.get('recordDays');
    if (data != null) {
      recordDays = data;
      bool isTodayPresent = recordDays.any(
          (e) => e["name"] == DateFormat('yyyy-MM-dd').format(DateTime.now()));
      if (!isTodayPresent) {
        recordDays.add({
          "name": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "records": []
        });
        box.put('recordDays', recordDays);
      }
    } else {
      recordDays = [
        {"name": DateFormat('yyyy-MM-dd').format(DateTime.now()), "records": []}
      ];
      box.put('recordDays', recordDays);
    }
  }

  saveData(data) {
    box.put('recordDays', data);
  }
}

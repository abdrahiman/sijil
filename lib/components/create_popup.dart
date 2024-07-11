import 'package:flutter/material.dart';

class FloatingBtn extends StatefulWidget {
  final Function(Map<String, String>) addRecord;

  const FloatingBtn(this.addRecord, {Key? key}) : super(key: key);

  @override
  State<FloatingBtn> createState() => _FloatingBtnState();
}

class _FloatingBtnState extends State<FloatingBtn> {
  String pickedStartTime = "20:00";
  String pickedEndTime = "21:00";
  String recordName = "";

  void addEvent() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                setState(() {
                                  pickedStartTime =
                                      "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
                                });
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(244, 244, 244, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(pickedStartTime)),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.arrow_right_rounded),
                        const SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                setState(() {
                                  pickedEndTime =
                                      "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}";
                                });
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(244, 244, 244, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(pickedEndTime)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      minLines: 3,
                      maxLines: 5,
                      onChanged: (value) {
                        setState(() => recordName = value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Type what you did in this time...",
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (validateInputs()) {
                          widget.addRecord({
                            "name": recordName,
                            "startTime": pickedStartTime,
                            "endTime": pickedEndTime
                          });
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool validateInputs() {
    if (recordName.isEmpty) {
      showValidationDialog("Please enter a record name !!");
      return false;
    }
    // Validate start time is before end time
    if (!isStartTimeBeforeEndTime()) {
      showValidationDialog("Start time must be before end time !!");
      return false;
    }
    return true;
  }

  bool isStartTimeBeforeEndTime() {
    // Assuming time format is HH:mm
    var startTimeParts = pickedStartTime.split(":");
    var endTimeParts = pickedEndTime.split(":");

    var startHour = int.parse(startTimeParts[0]);
    var startMinute = int.parse(startTimeParts[1]);
    var endHour = int.parse(endTimeParts[0]);
    var endMinute = int.parse(endTimeParts[1]);

    if (startHour < endHour) {
      return true;
    } else if (startHour == endHour && startMinute < endMinute) {
      return true;
    }
    return false;
  }

  void showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Validation Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: addEvent,
      elevation: 0.1,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}

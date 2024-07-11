import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  String? title = '';
  String? note = '';

  bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        backgroundColor: Colors.orange[200],
      ),
      backgroundColor: Colors.orange[100],
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              textDirection:
                  isRTL(title!) ? TextDirection.rtl : TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Title...',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                textDirection:
                    isRTL(note!) ? TextDirection.rtl : TextDirection.ltr,
                onChanged: (value) {
                  setState(() {
                    note = value;
                  });
                },
                decoration: new InputDecoration.collapsed(
                    hintText: 'Start Typing...', border: InputBorder.none),
                minLines: 20,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

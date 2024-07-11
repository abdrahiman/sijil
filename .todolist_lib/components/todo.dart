import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/components/db.dart';

class TodoCard extends StatefulWidget {
  final int index;
  final Map todo;
  final TodosDB db;
  const TodoCard(this.index, this.todo, this.db, {super.key});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  void remove(int i) {
    setState(() {
      widget.db.todos.removeAt(i);
    });
  }

  void toggelCheck(bool? v, int i) {
    setState(() {
      widget.db.todos[i]['isDone'] = !widget.db.todos[i]['isDone'];
      widget.db.saveData(widget.db.todos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),
          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              onPressed: (ctx) {
                remove(widget.index);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Checkbox(
              value: widget.todo['isDone'],
              onChanged: (v) => toggelCheck(v, widget.index),
              activeColor: Colors.black,
            ),
            Text(widget.todo['title'], style: const TextStyle(fontSize: 18))
          ]),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/components/db.dart';
import 'package:myapp/components/todo.dart';
import 'package:myapp/pages/note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TodosDB db = TodosDB();

  @override
  void initState() {
    super.initState();
    db.loadData();
  }

  void addTodo() {
    showDialog(
        context: context,
        builder: (context) {
          String newTodo = '';
          return AlertDialog(
              title: const Text('Add Todo'),
              backgroundColor: Colors.orange[100],
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                        autofocus: true,
                        onChanged: (value) {
                          newTodo = value;
                        }),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          db.todos.add({'title': newTodo, 'isDone': false});
                          db.saveData(db.todos);
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[300],
                          elevation: 0,
                          textStyle: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Text('Add Todo'),
                    ),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],
        appBar: AppBar(
          title: const Text("TODO"),
          centerTitle: true,
          backgroundColor: Colors.orange[300],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTodo,
          elevation: 0,
          backgroundColor: Colors.orange[500],
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: Colors.orange[100],
          child: Container(
              padding: const EdgeInsets.only(left: 10, top: 60),
              child: Column(children: [
                FilledButton(
                    child: const Text("Create Note"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Note()),
                      );
                    }),
              ])),
        ),
        body: Container(
            padding:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 30),
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: db.todos.length,
                // physics: BouncingScrollPhysics(),
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TodoCard(index, db.todos[index], db);
                })));
  }
}

import 'package:flutter/material.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var daysRequiredController = TextEditingController();


  void showButtonSheet(Todo task, int index) {
    scaffolState.currentState!.showBottomSheet(
          (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text('Title: ${task.title}'),
              Text('Description: ${task.description}', softWrap: true),
              Text('Days Required: ${task.requiredDays}'),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: FittedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        this.task.remove(task);
                        //myTaskList.removeTask(index);
                        Navigator.of(context).pop();
                        //updateUI();
                        setState(() {});
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
  AlertMessage(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            title: Text("Add Task"),
            content: Container(
              height: 250,
              width: 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text("Title"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 45, horizontal: 10),
                        label: Text("Description"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: daysRequiredController,
                      decoration: InputDecoration(
                        label: Text("Days Required"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty &&
                        descriptionController.text.trim().isNotEmpty &&
                        daysRequiredController.text.trim().isNotEmpty) {
                      task.add(Todo(
                          titleController.text.trim(),
                          descriptionController.text.trim(),
                          int.parse(daysRequiredController.text.trim())));
                      clearDialog();
                      if (mounted) {
                        setState(() {});
                      }
                    }
                  },
                  child: Text("Save")),
            ],
          ));
        });
  }

  clearDialog() {
    titleController.clear();
    descriptionController.clear();
    daysRequiredController.clear();
    Navigator.of(context).pop();
  }

  List<Todo> task = [];
  final GlobalKey<FormState> formInput = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffolState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolState,
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text("Task Management"),
        centerTitle: true,
        elevation: 6,
      ),
      body: Center(
        child: ListView.separated(
          itemCount: task.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(
                title: Text(task[index].title),
                subtitle: Text(task[index].description),
              ),
              onLongPress: () {
                showButtonSheet(task[index], index);
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertMessage(context);

          if (mounted) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo {
  String title, description;
  int requiredDays;

  Todo(this.title, this.description, this.requiredDays);
}

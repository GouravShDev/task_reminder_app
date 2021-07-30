import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/models/todo.dart';

import '../widgets/date_input.dart';
import '../widgets/time_input.dart';
import '../providers/todo_provider.dart';

class AddEditToDoScreen extends StatefulWidget {
  const AddEditToDoScreen();
  static const route = '/addToDo';

  @override
  _AddEditToDoScreenState createState() => _AddEditToDoScreenState();
}

class _AddEditToDoScreenState extends State<AddEditToDoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  late DateTime selectedDate = DateTime.now();
  ToDo? _task;
  late String _taskName;
  var _isInit = false;
  late ToDoList _toDoProvider;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _toDoProvider = Provider.of<ToDoList>(context, listen: false);
      final String? taskId =
          ModalRoute.of(context)!.settings.arguments as String?;
      print(taskId);
      if (taskId != null) {
        _task = _toDoProvider.findById(taskId);
        print(_task!.title);
      }
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Task',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: mediaQuery.size.width * 0.06),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      onChanged: (value) {
                        _taskName = value;
                      },
                      initialValue: (_task != null) ? _task!.title : "",
                      decoration: InputDecoration(
                        labelText: 'Task',
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Task name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    (_task == null)
                        ? DateInput((DateTime date) {
                            selectedDate = date;
                          })
                        : DateInput(
                            (DateTime date) {
                              selectedDate = date;
                            },
                            initValue: _task!.date,
                          ),
                    (_task == null)
                        ? TimeInput((TimeOfDay time) {
                            selectedTime = time;
                          })
                        : TimeInput(
                            (TimeOfDay time) {
                              selectedTime = time;
                            },
                            initValue: _task!.date,
                          ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.size.height * 0.1),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            final selectedDateAndTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute);
                            print(selectedDateAndTime);
                            _toDoProvider.addItem(
                                _taskName, selectedDateAndTime);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

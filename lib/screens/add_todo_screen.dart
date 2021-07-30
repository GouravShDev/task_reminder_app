import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/date_input.dart';
import '../widgets/time_input.dart';

import '../providers/todo_provider.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({Key? key}) : super(key: key);
  static const route = '/addToDo';

  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TimeOfDay selectedTime;
  late DateTime selectedDate;
  late String _taskName;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final toDoProvider = Provider.of<ToDoList>(context, listen: false);
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
                    DateInput((DateTime date) {
                      selectedDate = date;
                    }),
                    TimeInput((TimeOfDay time) {
                      selectedTime = time;
                    }),
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
                            toDoProvider.addItem(
                                _taskName, selectedDateAndTime);
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

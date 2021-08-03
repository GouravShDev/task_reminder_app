import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../services/notification_service.dart';
import '../theme_builder.dart';
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
  String? _currentTaskName;
  DateTime? _currentTaskDueDate;
  TimeOfDay? _currentTaskDueTime;
  var _isInit = false;
  late ToDoList _toDoProvider;
  bool _isNotificationOn = true;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _toDoProvider = Provider.of<ToDoList>(context, listen: false);
      final int? taskId = ModalRoute.of(context)!.settings.arguments as int?;
      if (taskId != null) {
        _task = _toDoProvider.findById(taskId);
        _taskName = _task!.name;
        _currentTaskName = _taskName;
        selectedDate = _task!.date;
        selectedTime =
            TimeOfDay(hour: _task!.date.hour, minute: _task!.date.minute);
        _currentTaskDueDate = selectedDate;
        _currentTaskDueTime = selectedTime;
      }
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    NotificationService.initalilize();
    super.initState();
  }

  void _handleFormSubmission() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // Check if Task modified
      if (_currentTaskName != _taskName ||
          _currentTaskDueDate != selectedDate ||
          _currentTaskDueTime != selectedTime) {
        final selectedDateAndTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute);

        // if task exist update it
        // otherwise create a new task
        int curTaskId = await _toDoProvider
            .addUpdateItem(_taskName, selectedDateAndTime, id: _task?.id);
        print('new Id ' + curTaskId.toString());
        // if notification alert is on, schedule notification
        if (_isNotificationOn) {
          print('Schedule Notification at : $selectedDateAndTime');

          // Checking if input date and time is not alreay past
          // Can't schedule current dateTime notification
          if (selectedDateAndTime.isAfter(DateTime.now())) {
            NotificationService.scheduledNotification(
                id: curTaskId,
                message: formatDate(
                    DateTime(2019, 08, 1, selectedDateAndTime.hour,
                        selectedDateAndTime.minute),
                    [hh, ':', nn, " ", am]).toString(),
                title: _taskName,
                scheduledDate: selectedDateAndTime);
          }
        } else {
          NotificationService.cancelScheduledNotification(_task?.id);
        }
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final themeProvider = ThemeBuilder.of(context);
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
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                      autofocus: true,
                      onChanged: (value) {
                        _taskName = value;
                      },
                      initialValue: _task?.name,
                      // initialValue: _task.title ?? "",
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
                    DateInput(
                      (DateTime date) {
                        selectedDate = date;
                      },
                      initValue: _task?.date,
                    ),
                    TimeInput(
                      (TimeOfDay time) {
                        selectedTime = time;
                      },
                      initValue: _task?.date,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Notification Alert ' +
                                (this._isNotificationOn ? 'On' : 'Off'),
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                this._isNotificationOn =
                                    !this._isNotificationOn;
                              });
                            },
                            icon: Icon(
                              (_isNotificationOn)
                                  ? Icons.notifications_active
                                  : Icons.notifications,
                              color: (_isNotificationOn)
                                  ? themeProvider!.materialColor.shade400
                                  : Colors.grey,
                              // color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: _handleFormSubmission,
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

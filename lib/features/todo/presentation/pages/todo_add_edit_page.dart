import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as mr;
import 'package:provider/provider.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import '../blocs/todo_bloc/todo_bloc.dart';
import '../../../../core/services/notification_service.dart';

import '../widgets/date_input.dart';
import '../widgets/time_input.dart';

import '../../../../injection_container.dart';

class TodoAddEditPage extends StatefulWidget {
  final Todo? currentTodo;
  TodoAddEditPage({this.currentTodo, Key? key}) : super(key: key);

  static const route = '/todo-add-edit';

  @override
  _TodoAddEditPageState createState() => _TodoAddEditPageState();
}

class _TodoAddEditPageState extends State<TodoAddEditPage> {
  // Key for Form widget
  final _formKey = GlobalKey<FormState>();

  int? _currentTaskId;
  late String _taskName;
  // Intializing default values for date and Time input widget
  late TimeOfDay _selectedTime;
  late DateTime _selectedDate;

  late bool _isNotificationOn;
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newTodo = TasksCompanion(
        id: (_currentTaskId == null)
            ? mr.Value.absent()
            : mr.Value(_currentTaskId!),
        name: mr.Value(_taskName),
        due: mr.Value(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        )),
        hasAlert: mr.Value(_isNotificationOn),
      );

      context.read<TodoBloc>()..add(AddTodo(newTodo));

      // check if alert was on previous and now is off
      // if so, unschedule the notification
      if (widget.currentTodo != null &&
          !_isNotificationOn &&
          widget.currentTodo!.hasAlert) {
        locator<NotificationService>()
            .cancelNotification(widget.currentTodo!.id);
      }
      final snackBarMessage = (widget.currentTodo == null)
          ? 'Task added Successfully'
          : 'Task updated Successfully';
      Navigator.of(context).pop(snackBarMessage);
    }
  }

  @override
  void initState() {
    print(widget.currentTodo?.id);
    _currentTaskId = widget.currentTodo?.id;
    _taskName = widget.currentTodo?.name ?? '';
    _isNotificationOn = widget.currentTodo?.hasAlert ?? true;
    final DateTime date = widget.currentTodo?.due ?? DateTime.now();
    _selectedTime = TimeOfDay(hour: date.hour, minute: date.minute);
    _selectedDate = date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: mediaQuery.size.width * 0.05,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      autofocus: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Task',
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                      onChanged: (value) {
                        _taskName = value;
                      },
                      initialValue: _taskName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Task name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    DateInput(
                      (DateTime date) {
                        _selectedDate = date;
                      },
                      initValue: _selectedDate,
                    ),
                    TimeInput(
                      (TimeOfDay time) {
                        _selectedTime = time;
                      },
                      // _selectedDate Contains the todo time
                      initValue: _selectedDate,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Notification Alert ' +
                                (this._isNotificationOn ? 'On' : 'Off'),
                            style: TextStyle(
                              fontSize: 18,
                            ),
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
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: ElevatedButton(
                        onPressed: _submitForm,
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

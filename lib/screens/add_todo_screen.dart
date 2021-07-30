import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({Key? key}) : super(key: key);
  static const route = '/addToDo';

  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final _formKey = GlobalKey<FormState>();

  // String? _setTime, _setDate;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  // String _hour = DateTime.now().hour.toString(),
  //     _minute = DateTime.now().hour.toString(),
  //     _time = DateTime.now().hour.toString();
  late String _taskName, _hour, _minute, _time;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final labelStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontSize: 16, color: Color.fromRGBO(151, 154, 151, 1));
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Choose Date',
                                  style: labelStyle,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Container(
                                          // width: mediaQuery.size.width * 0.75,
                                          // width: double.infinity,
                                          margin: EdgeInsets.only(top: 16),
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            _dateController.text,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1.0,
                                                    color: Theme.of(context)
                                                        .buttonTheme
                                                        .colorScheme!
                                                        .background)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        padding: EdgeInsets.only(top: 4),
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Theme.of(context).accentColor,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose Time',
                          style: labelStyle,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _selectTime(context);
                                },
                                child: Container(
                                  // width: mediaQuery.size.width * 0.35,
                                  margin: EdgeInsets.only(top: 16),
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    _timeController.text,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .background)),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  _selectTime(context);
                                },
                                padding: EdgeInsets.only(top: 4),
                                icon: Icon(
                                  Icons.access_time,
                                  color: Theme.of(context).accentColor,
                                ))
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.size.height * 0.1),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Processing Data')
                            //   ),
                            // );
                            final selectedDateAndTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute);
                            print(selectedDateAndTime);
                            // print(
                            //     "TaskName: $_taskName\nDate: ${_dateController.text}\nTime: ${_timeController.text}");
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme_builder.dart';

class DateInput extends StatefulWidget {
  final Function updateDate;
  final DateTime? initValue;
  const DateInput(this.updateDate, {this.initValue});

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    if (widget.initValue != null) {
      _dateController.text = DateFormat.yMMMMd().format(widget.initValue!);
      selectedDate = widget.initValue!;
    } else {
      _dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    }
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: (DateTime.now().compareTo(selectedDate) < 0)
            ? selectedDate
            : DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        widget.updateDate(selectedDate);
        _dateController.text = DateFormat.yMMMMd().format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontSize: 16, color: Color.fromRGBO(151, 154, 151, 1));

    final themeProvider = ThemeBuilder.of(context);
    return Container(
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
                          color: themeProvider!.materialColor.shade400,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

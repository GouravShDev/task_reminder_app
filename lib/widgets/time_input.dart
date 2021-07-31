import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class TimeInput extends StatefulWidget {
  final Function updateTime;
  final DateTime? initValue;
  const TimeInput(this.updateTime, {this.initValue});

  @override
  _TimeInputState createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  late TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  late String _hour, _minute, _time;

  TextEditingController _timeController = TextEditingController();

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
        widget.updateTime(selectedTime);
      });
  }

  @override
  void initState() {
    if (widget.initValue != null) {
      _timeController.text = formatDate(
          DateTime(
              2019, 08, 1, widget.initValue!.hour, widget.initValue!.minute),
          [hh, ':', nn, " ", am]).toString();
      selectedTime = TimeOfDay(
          hour: widget.initValue!.hour, minute: widget.initValue!.minute);
    } else {
      _timeController.text = formatDate(
          DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
          [hh, ':', nn, " ", am]).toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontSize: 16, color: Color.fromRGBO(151, 154, 151, 1));
    return Column(
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
    );
  }
}

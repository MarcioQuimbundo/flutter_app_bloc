import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key, this.child, this.labelText, this.valueText, this.valueStyle, this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  DateTimePicker(
      {Key key,
      this.labelText,
      this.showIcon = false,
      @required this.selectedDate,
      @required this.selectedTime,
      @required this.selectDate,
      @required this.selectTime})
      : super(key: key);

  final bool showIcon;
  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle valueStyle = Theme.of(context).textTheme.subhead;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        showIcon
            ? Padding(
                child: Icon(Icons.calendar_today),
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
              )
            : null,
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

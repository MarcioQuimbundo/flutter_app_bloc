import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../common/common.dart';
import '../login/validators.dart';

class FormPage extends StatefulWidget {
  @override
  FormPageState createState() {
    return FormPageState();
  }
}

class FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _types = <String>['', 'Inspection', 'Repair', 'Replacement', 'Warranty Expired',];
  String _type = '';

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);

  Widget _buildPage({int index, Color color}) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: color,
      child: SafeArea(
          top: true,
          bottom: false,
          child: Form(
              key: Key("$_formKey $index"),
              autovalidate: true,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.description),
                          labelText: 'Type',
                        ),
                        isEmpty: _type == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _type,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
//                                newContact.favoriteColor = newValue;
                                _type = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _types.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                  ),
                  DateTimePicker(
                    labelText: 'From',
                    showIcon: true,
                    selectedDate: _fromDate,
                    selectedTime: _fromTime,
                    selectDate: (DateTime date) {
                      setState(() {
                        _fromDate = date;
                      });
                    },
                    selectTime: (TimeOfDay time) {
                      setState(() {
                        _fromTime = time;
                      });
                    },
                  ),
                  DateTimePicker(
                    labelText: 'To',
                    showIcon: true,
                    selectedDate: _toDate,
                    selectedTime: _toTime,
                    selectDate: (DateTime date) {
                      setState(() {
                        _toDate = date;
                      });
                    },
                    selectTime: (TimeOfDay time) {
                      setState(() {
                        _toTime = time;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Dob',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        child: const Text('Submit'),
                        onPressed: null,
                      )),
                ],
              ))),
    );
  }

  Widget _buildPageView() {
    return PageView(
      children: [
        _buildPage(index: 1, color: Colors.white),
        _buildPage(index: 2, color: Colors.blue),
//        _buildPage(index: 3, color: Colors.indigo),
//        _buildPage(index: 4, color: Colors.red),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

//      persistentFooterButtons: <Widget>[IconButton(icon: Icon(Icons.event), onPressed: null)],
      appBar: AppBar(
        title: Text("Create Work Order"),
      ),
      body: _buildPageView(),
    );
  }
}

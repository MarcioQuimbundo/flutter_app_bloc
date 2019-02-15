import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../common/common.dart';
import '../login/validators.dart';
import 'dart:math' as math;

class FormPage extends StatefulWidget {
  @override
  FormPageState createState() {
    return FormPageState();
  }
}

class FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _types = <String>[
    '',
    'Inspection',
    'Repair',
    'Replacement',
    'Warranty Expired',
  ];
  String _type = '';
  List<ImageInputAdapter> _images = [];
  PageController _controller = PageController(initialPage: 1);
  List<Widget> _pages = [];

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = TimeOfDay.now();

  Widget _buildForm({int index}) {
    return Form(
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
                    labelText: 'Fault Type',
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
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              decoration: const InputDecoration(
                icon: const Icon(Icons.location_on),
                hintText: 'Enter location',
                labelText: 'Location',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              decoration: const InputDecoration(
                icon: const Icon(Icons.important_devices),
                hintText: 'Enter equipment id',
                labelText: 'Equipment ID',
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.insert_drive_file),
                hintText: 'Enter serial number',
                labelText: 'Serial Number',
              ),
            ),

//                  DateTimePicker(
//                    labelText: 'From',
//                    showIcon: true,
//                    selectedDate: _fromDate,
//                    selectedTime: _fromTime,
//                    selectDate: (DateTime date) {
//                      setState(() {
//                        _fromDate = date;
//                      });
//                    },
//                    selectTime: (TimeOfDay time) {
//                      setState(() {
//                        _fromTime = time;
//                      });
//                    },
//                  ),
            DateTimePicker(
              labelText: 'Incident Date',
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
              labelText: 'Reported Date',
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
            DateTimePicker(
              labelText: 'Technician Visit Date',
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
            DateTimePicker(
              labelText: 'Resolution Date',
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
                icon: const Icon(Icons.description),
                hintText: 'Describe the case',
                labelText: 'Description',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
//                  TextFormField(
//                    decoration: const InputDecoration(
//                      icon: const Icon(Icons.phone),
//                      hintText: 'Enter a phone number',
//                      labelText: 'Phone',
//                    ),
//                    keyboardType: TextInputType.phone,
//                    inputFormatters: [
//                      WhitelistingTextInputFormatter.digitsOnly,
//                    ],
//                  ),
//                  TextFormField(
//                    decoration: const InputDecoration(
//                      icon: const Icon(Icons.email),
//                      hintText: 'Enter a email address',
//                      labelText: 'Email',
//                    ),
//                    keyboardType: TextInputType.emailAddress,
//                  ),
            ImageFormField<ImageInputAdapter>(
              shouldAllowMultiple: true,
              buttonBuilder: (BuildContext context, int count) => Container(
                    padding: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    child: Text(
                      count == null || count < 1 ? "Upload Image" : "Upload More",
                      textAlign: TextAlign.center,
                    ),
                  ),
              initializeFileAsImage: (file) => ImageInputAdapter(file: file),
              onSaved: (val) => _images = val,
              previewImageBuilder: (BuildContext context, image) => image.widgetize(),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter name',
                labelText: 'Reported by',
              ),
            ),
//            Container(
//                padding: const EdgeInsets.only(top: 20.0),
//                child: Center(
//                  child: RaisedButton(
//                    elevation: 2,
//                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//                    child: const Text('Submit'),
//                    onPressed: () => print("submit"),
//                    ),
//                  )),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _pages = [_buildPage(index: 1, color: Colors.white)];
  }

  Widget _buildPage({int index, Color color}) {
    return Container(
      alignment: AlignmentDirectional.center,
      color: color,
      child: _buildForm(index: index),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _controller,
      itemCount: _pages.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => _pages[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Engagement"),
      ),
      body: SafeArea(top: false, child: _buildPageView()),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new Equipment",
        child: Icon(Icons.add),
//        key: ArchSampleKeys.editTodoFab,
        onPressed: () {
          Widget newPage = _buildPage(
              index: _pages.length + 1,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0));
          _pages.add(newPage);
          setState(() {
            _controller.animateToPage(_pages.length-1,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}

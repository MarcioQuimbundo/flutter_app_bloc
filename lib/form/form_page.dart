import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_bloc/equipment/equipment.dart';
import 'package:flutter_app_bloc/equipment/equipment_repository.dart';
import 'package:flutter_app_bloc/form/form_event.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../api_provider.dart';
import '../application.dart';
import '../common/common.dart';
import 'form_bloc.dart';
import 'form_respository.dart';

class FormPage extends StatefulWidget {
  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<ImageInputAdapter> _images = [];
  PageController _controller = PageController(initialPage: 0);
  Map<Key, TextEditingController> _textEditingControllers = Map.fromIterable(
    _fields,
    key: (item) => Key(item.toString()),
    value: (val) => TextEditingController(),
  );
  List<Widget> _pages = [];

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = TimeOfDay.now();

  static List<String> _fields = [
    "fault field",
    "equipment field",
    "location field",
    "serial number field",
    "description field",
    "reported by field",
  ];

  FormBloc _formBloc = FormBloc(
      equipmentRepository:
          EquipmentRepository(apiProvider: DVIApiProvider(baseURL)),
      formRepository: FormRepository(apiProvider: DVIApiProvider(baseURL)));
  // TextEditingController _typeAheadController = TextEditingController();

  Widget _buildForm({int index}) {
    return Form(
        key: Key("$_formKey $index"),
        autovalidate: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            FormField(
              builder: (FormFieldState state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.description),
                    labelText: 'Fault Type',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: state.value,
                      isDense: true,
                      onChanged: (newValue) {
                        _formBloc.faultTypeSelected.add(newValue);
                        state.didChange(newValue);
                      },
                      items: _formBloc.dropdownValues.map((String value) {
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
            StreamBuilder(
                stream: _formBloc.location,
                builder: (context, snapshot) => TypeAheadField(
                      key: Key("location field"),
                      textFieldConfiguration: TextFieldConfiguration(
                          controller:
                              _textEditingControllers[Key("location field")],
                          // autofocus: true,
                          // onChanged: _formBloc.locationChanged,
                          decoration: InputDecoration(
                            icon: Icon(Icons.location_on),
                            hintText: 'Enter location',
                            labelText: 'Location',
                          )),
                      suggestionsCallback: (pattern) async {
                        return await _formBloc.equipmentRepository
                            .retrieveEquipmentList();
                      },
                      itemBuilder: (context, Equipment suggestion) {
                        return ListTile(
                          title: Text(suggestion.name),
                        );
                      },
                      onSuggestionSelected: (Equipment suggestion) {
                        _textEditingControllers[Key("location field")].text =
                            suggestion.name;
                        _formBloc.locationSelected.add(suggestion.name);
                      },
                    )),
            TypeAheadFormField(
              key: Key("equipment field"),
              textFieldConfiguration: TextFieldConfiguration(
                  controller: _textEditingControllers[Key("equipment field")],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.important_devices),
                    hintText: 'Enter equipment id',
                    labelText: 'Equipment ID',
                  )),
              suggestionsCallback: (pattern) async {
                return await _formBloc.equipmentRepository
                    .retrieveEquipmentList();
              },
              itemBuilder: (context, suggestion) {
                Equipment equip = suggestion;
                return ListTile(title: Text(equip.name));
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              // },
              onSuggestionSelected: (Equipment suggestion) {
                _textEditingControllers[Key("equipment field")].text =
                    suggestion.name;
                _formBloc.equipmentIDSelected.add(suggestion.name);
              },
            ),
            StreamBuilder<String>(
                stream: _formBloc.serialNumber,
                builder: (context, snapshot) => TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) =>
                          _formBloc.serialNumberChanged.add(value),
                      decoration: InputDecoration(
                          icon: Icon(Icons.insert_drive_file),
                          hintText: 'Enter serial number',
                          labelText: 'Serial Number',
                          errorText: snapshot.error),
                    )),
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
            StreamBuilder<String>(
              stream: _formBloc.description,
              builder: (context, snapshot) => TextField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.description),
                      hintText: 'Describe the case',
                      labelText: 'Description',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: _formBloc.descriptionChanged,
                  ),
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
                      count == null || count < 1
                          ? "Upload Image"
                          : "Upload More",
                      textAlign: TextAlign.center,
                    ),
                  ),
              initializeFileAsImage: (file) => ImageInputAdapter(file: file),
              onSaved: (val) => _images = val,
              previewImageBuilder: (BuildContext context, image) =>
                  image.widgetize(),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<String>(
                stream: _formBloc.reportedBy,
                builder: (context, snapshot) => TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) =>
                          _formBloc.reportedByChanged,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter name',
                          labelText: 'Reported by',
                          errorText: snapshot.error),
                    )),
            TextField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter name',
                labelText: 'Reported by',
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: RaisedButton(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: const Text('Submit'),
                    onPressed: () {
                      print("submit");
                      _formBloc.dispatch(SubmitForm());
                    },
                  ),
                )),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _pages = [_buildPage(index: 1, color: Colors.white)];
  }

  @override
  void dispose() {
    _formBloc.dispose();
    super.dispose();
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
        onPressed: () {
          Widget newPage = _buildPage(
              index: _pages.length + 1,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                  .withOpacity(1.0));
          _pages.add(newPage);
          setState(() {
            _controller.animateToPage(_pages.length - 1,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}

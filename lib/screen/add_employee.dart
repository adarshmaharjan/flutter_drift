import 'package:drift_tuts/db/app_db.dart';
import 'package:drift_tuts/widget/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/custom_text_form_field.dart';
import 'package:drift/drift.dart' as drift;

class AddEmployeeScreen extends StatefulWidget {
  AddEmployeeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  late AppDb _db;
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();
  DateTime? _dateOfBirth;

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.red,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child ?? const Text(''),
      ),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      _dobController.text = DateFormat('dd/MM/yyy').format(newDate);
    });
  }

  @override
  void initState() {
    super.initState();

    _db = AppDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              final entity = EmployeeCompanion(
                userName: drift.Value(_userNameController.text),
                firstName: drift.Value(_firstNameController.text),
                lastName: drift.Value(_lastNameController.text),
                dateOfBirth: drift.Value(_dateOfBirth!),
              );
              _db.insertEmployee(entity);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CustomFormFields(
              controller: _userNameController,
              textLabel: 'User Name',
            ),
            const SizedBox(height: 16),
            CustomFormFields(
              controller: _firstNameController,
              textLabel: 'First Name',
            ),
            const SizedBox(height: 16),
            CustomFormFields(
              controller: _lastNameController,
              textLabel: 'Last Name',
            ),
            const SizedBox(height: 16),
            // TextFormField(
            //   onTap: () => pickDateOfBirth(context),
            //   controller: _dobController,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: 'Date of birth',
            //     label: Text('Date of birth'),
            //   ),
            //   keyboardType: TextInputType.name,
            //   validator: (value) {
            //     if (value?.isNotEmpty ?? false) {
            //       return "Text field cannot be empty";
            //     }
            //     return null;
            //   },
            // ),
            CustomDatePickerField(
              callback: () => pickDateOfBirth(context),
              controller: _dobController,
              textLabel: 'Date of birth',
            ),
          ],
        ),
      ),
    );
  }
}

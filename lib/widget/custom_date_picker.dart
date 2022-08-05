import 'package:flutter/material.dart';

class CustomDatePickerField extends StatelessWidget {
  CustomDatePickerField({
    Key? key,
    required TextEditingController controller,
    required String textLabel,
    required VoidCallback callback,
  })  : _controller = controller,
        _textLabel = textLabel,
        _callback = callback,
        super(key: key);

  final TextEditingController _controller;
  final String _textLabel;
  final VoidCallback _callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _callback,
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Date of birth',
        label: Text('Date of birth'),
      ),
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value?.isNotEmpty ?? false) {
          return "Text field cannot be empty";
        }
        return null;
      },
    );
  }
}

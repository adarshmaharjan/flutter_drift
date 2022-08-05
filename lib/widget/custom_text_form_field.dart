import 'package:flutter/material.dart';

class CustomFormFields extends StatelessWidget {
  const CustomFormFields({
    Key? key,
    required TextEditingController controller,
    required String textLabel,
  })  : _controller = controller,
        _textLabel = textLabel,
        super(key: key);

  final TextEditingController _controller;
  final String _textLabel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: _textLabel,
        label: Text(_textLabel),
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

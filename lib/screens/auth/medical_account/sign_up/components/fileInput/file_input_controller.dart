import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/size_config.dart';
import 'package:permission_handler/permission_handler.dart';

class FileInputController extends TextEditingController {
  @override
  void clear() {
    text = '';
  }
}

class FileInputField extends StatefulWidget {
  final String labelText;
  final FileInputController controller;
  final Function() press;
  const FileInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.press,
  });

  @override
  State<FileInputField> createState() => _FileInputFieldState();
}

class _FileInputFieldState extends State<FileInputField> {
  String? _errorText;

  void _clearError() {
    setState(() {
      _errorText = null;
    });
  }

  void _setError(String errorText) {
    setState(() {
      _errorText = errorText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          onPressed: widget.press,
          icon: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              getProportionateScreenWidth(6),
              getProportionateScreenWidth(25),
              getProportionateScreenWidth(10),
            ),
            child: const Icon(Icons.attach_file),
          ),
        ),
        errorText: _errorText,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Le fichier doit etre sélectionner';
        }
        return null;
      },
    );
  }
}

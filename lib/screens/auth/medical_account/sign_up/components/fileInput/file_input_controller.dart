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
  final VoidCallback? onFileSelected;
  const FileInputField({
    super.key,
    required this.labelText,
    required this.controller,
    this.onFileSelected,
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
          onPressed: () async {
            _clearError();
            final permissionStatus = await Permission.storage.request();
            if (permissionStatus == PermissionStatus.granted) {
              // SE LIMITER AU FICHIER D'EXTENSIONS JPG, PDF, DOC
              final file = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'pdf', 'doc'],
              );
              if (file != null) {
                widget.controller.text = file.files.single.name;
                widget.onFileSelected?.call();
              } else {
                _setError('Aucun fichier sélectionné');
              }
            } else {
              _setError('Permissions refusées');
            }
          },
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
          return 'Veuillez entrer un fichier de preuve';
        }
        return null;
      },
    );
  }
}

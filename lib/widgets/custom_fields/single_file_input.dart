import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:main_project/widgets/snack_bar.dart';

class SingleFileInput extends StatefulWidget {
  final FileType inputFileType;
  final String dialogTitle;
  final Function(FilePickerResult) upload;

  const SingleFileInput({
    super.key,
    required this.inputFileType,
    required this.dialogTitle,
    required this.upload,
  });

  @override
  State<SingleFileInput> createState() => _SingleFileInputState();
}

class _SingleFileInputState extends State<SingleFileInput> {
  FilePickerResult? pickedImage;
  PlatformFile? profileImageFile;
  bool isLoading = false;

  void pickImage() async {
    setState(() => isLoading = true);
    try {
      pickedImage = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        dialogTitle: widget.dialogTitle,
        type: widget.inputFileType,
      );
      if (pickedImage != null) {
        widget.upload(pickedImage!);
        setState(() {
          profileImageFile = pickedImage?.files.single;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AlertSnackBar(
            message: e.toString(),
            type: AlertType.error,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          width: 360,
        ),
      );
      print(e);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton(
          onPressed: pickImage,
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
          child: Text(
            'Choose',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          profileImageFile?.name ?? 'no file selected',
          style: Theme.of(context).textTheme.labelMedium?.merge(
                TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
        ),
        const Spacer(),
        SizedBox(
          width: 40,
          height: 35,
          child: pickedImage != null
              ? Image.memory(
                  pickedImage!.files.single.bytes!,
                )
              : isLoading
                  ? const CircularProgressIndicator()
                  : null,
        )
      ],
    );
  }
}

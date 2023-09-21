import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:main_project/widgets/snack_bar.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';
// import 'package:csv/csv.dart';

class CsvFileInput extends StatefulWidget {
  final Function(List<List>) upload;
  const CsvFileInput({super.key, required this.upload});

  @override
  State<CsvFileInput> createState() => _CsvFileInputState();
}

class _CsvFileInputState extends State<CsvFileInput> {
  bool isLoading = false;

  Future readAndParseCSV() async {
    setState(() => isLoading = true);
    try {
      List<List> mainData = [];
      List csvFileContentList = [];
      PlatformFile file = await _selectedCSVFile();

      String s = String.fromCharCodes(file.bytes!);
      // Get the UTF8 decode as a Uint8List
      Uint8List outputAsUint8List = Uint8List.fromList(s.codeUnits);
      // split the Uint8List by newline characters to get the csv file rows
      // print(utf8.decode(outputAsUint8List));

      csvFileContentList = utf8.decode(outputAsUint8List).split('\n');

      // print(csvFileContentList[0].toString().split(',')); // [id, firstname, lastname, email, department, team ]

      if (csvFileContentList.length <= 2) {
        throw Exception('No data found in file, try change file and reupload.');
      }

      for (var data in csvFileContentList) {
        mainData.add(data.toString().trim().split(','));
      }

      print(mainData);
      setState(() => isLoading = false);

      widget.upload(mainData);
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
      setState(() => isLoading = false);
      throw Exception(e);
    }
  }

  Future<PlatformFile> _selectedCSVFile() async {
    FilePickerResult? pickedFile;
    pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (pickedFile != null) {
      // widget.upload(pickedFile!);
      return pickedFile.files.single;
    } else {
      throw Exception('File not found! something went wrong, try again!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          )
        : PrimaryButton(
            paddingHorizontal: 14,
            title: 'Upload CSV',
            onTap: readAndParseCSV,
            fontSize: 14,
            paddingVertical: 20,
          );
  }
}

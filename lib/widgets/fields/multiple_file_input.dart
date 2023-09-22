import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';

class MultipleFileInput extends StatefulWidget {
  final FileType fileType;
  final String dialogTitle;
  const MultipleFileInput(
      {super.key, required this.fileType, required this.dialogTitle});

  @override
  State<MultipleFileInput> createState() => _MultipleFileInputState();
}

class _MultipleFileInputState extends State<MultipleFileInput> {
  List<PlatformFile> resultFiles = [];
  bool isloading = false;
  void uploadFiles() async {
    setState(() {
      isloading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: widget.fileType,
        dialogTitle: widget.dialogTitle,
      );
      if (result != null) {
        print(result.files.length);
        setState(() {
          resultFiles = [...resultFiles, ...result.files];
          print(resultFiles);
        });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryButton(
          title: 'Upload Photos',
          onTap: uploadFiles,
          paddingHorizontal: 14,
          fontSize: 16,
          paddingVertical: 18,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment:
              resultFiles.isEmpty ? Alignment.center : Alignment.topCenter,
          constraints: resultFiles.isNotEmpty
              ? BoxConstraints(
                  maxHeight:
                      resultFiles.length > 2 ? 200 : resultFiles.length * 80)
              : null,
          child: resultFiles.isEmpty
              ? isloading
                  ? CircularProgressIndicator()
                  : Text('No Files',
                      style: Theme.of(context).textTheme.displaySmall)
              : ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: resultFiles.length,
                  itemBuilder: (context, index) {
                    final file = resultFiles[index];
                    final fileSize = file.size / (1024 * 1024);
                    return Container(
                      height: 60,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            height: 50,
                            width: 50,
                            child: file.bytes != null
                                ? Image.memory(file.bytes!)
                                : const Icon(Icons.image),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(file.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // LinearProgressIndicator(value: f,)
                                    Text(
                                      'Completed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      '${fileSize.toStringAsFixed(2)} MB',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                resultFiles.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}

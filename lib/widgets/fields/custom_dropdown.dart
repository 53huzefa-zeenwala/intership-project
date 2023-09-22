import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> dropItems;
  final String labelText;
  final Function(String?) onSaved;
  final String? defaultValue;
  final bool isEnable;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;

  const CustomDropDown(
      {super.key,
      required this.dropItems,
      required this.labelText,
      required this.onSaved,
      this.defaultValue,
      this.isEnable = true,
      this.validator,
      this.onChange});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.onChange == null ? dropdownValue : widget.defaultValue,
      // focusColor: Colors.grey.shade200,
      items: widget.isEnable
          ? widget.dropItems.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            }).toList()
          : null,
      style: Theme.of(context).textTheme.labelMedium,
      decoration: InputDecoration(
        enabled: widget.isEnable,
        labelText: widget.labelText,
        filled: false,
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
      onSaved: widget.onSaved,
      validator: widget.validator,
      onChanged: widget.onChange ?? (value) {setState(() => dropdownValue = value.toString());},
    );
  }
}

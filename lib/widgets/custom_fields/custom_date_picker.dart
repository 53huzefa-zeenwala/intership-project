import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? defaultValue;
  final bool isEnable;
  final String labelText;
  final Function(DateTime?) onSaved;
  final String? Function(String?)? validator;

  const CustomDatePicker(
      {super.key,
      this.defaultValue,
      this.isEnable = true,
      this.labelText = 'Select Date',
      required this.onSaved, this.validator});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
            child: child!);
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enabled: widget.isEnable,
      onTap: () => widget.isEnable ? _selectDate(context) : null,
      controller: TextEditingController(
        text: selectedDate?.toLocal().toString().split(' ')[0],
      ),
      style: Theme.of(context).textTheme.labelMedium,
      decoration: InputDecoration(
        enabled: widget.isEnable,
        labelText: widget.isEnable ? widget.labelText : null,
        suffixIcon: const Icon(Icons.calendar_today),
        filled: false,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
validator: widget.validator,
      onSaved: (newValue) => widget.onSaved(selectedDate),
    );
  }
}

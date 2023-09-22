import 'package:flutter/material.dart';
import 'package:main_project/widgets/fields/custom_dropdown.dart';

class FilterDialog extends StatelessWidget {
  final Widget filters;
  final double height;
  const FilterDialog({
    super.key,
    required this.filters,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        color: Colors.white,
        width: 250,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
              ),
              height: 60,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Search Filters',
                style: Theme.of(context).textTheme.displayMedium?.merge(
                      const TextStyle(letterSpacing: 1.1),
                    ),
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: filters,
              ),
            ),
            Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: BorderDirectional(top: BorderSide(width: 1))),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.merge(TextStyle(color: Colors.grey.shade600)))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Apply',
                          style: Theme.of(context).textTheme.displaySmall),
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}

class Filter extends StatelessWidget {
  final String title;
  final List<String> dropItems;
  final String currentValue;
  final Function(String?) onChange;

  const Filter(
      {super.key,
      required this.title,
      required this.dropItems,
      required this.currentValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 2),
          child: Text(title, style: Theme.of(context).textTheme.displaySmall),
        ),
        CustomDropDown(
          dropItems: dropItems,
          labelText: '',
          onSaved: (val) => null,
          defaultValue: currentValue,
          onChange: onChange,
        )
        // Container(
        //   height: 45,
        //   decoration: BoxDecoration(
        //     borderRadius: const BorderRadius.all(
        //       Radius.circular(6),
        //     ),
        //     color: Theme.of(context).primaryColorLight,
        //   ),
        //   child: DropdownButton(
        //     underline: Container(),
        //     isExpanded: true,
        //     padding: const EdgeInsets.only(left: 10),
        //     borderRadius: BorderRadius.circular(6),
        //     value: currentValue,
        //     items: dropItems.map((item) {
        //       return DropdownMenuItem(
        //         value: item,
        //         child: Text(
        //           item,
        //           overflow: TextOverflow.ellipsis,
        //           style: Theme.of(context).textTheme.labelSmall,
        //         ),
        //       );
        //     }).toList(),
        //     onChanged: (Object? val) => onChange(val!),
        //   ),
        // )
      ],
    );
  }
}

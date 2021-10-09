import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final List<String> menuItem;
  final String hint;
  final Function(String?) onPressed;

  DropdownMenu(
      {Key? key,
      required this.menuItem,
      required this.hint,
      required this.onPressed})
      : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late String dropdownValue = widget.menuItem[0];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: dropdownValue,
        hint: Text(widget.hint),
        onChanged: (String? newValue) {
          setState(() {
            widget.onPressed(newValue);
            dropdownValue = newValue!;
          });
        },
        items: widget.menuItem.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

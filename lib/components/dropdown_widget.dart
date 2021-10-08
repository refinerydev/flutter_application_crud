import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final List<String> menuItem;
  final Function(String) onAnswer;

  DropdownMenu({Key? key, required this.menuItem, required this.onAnswer})
      : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: widget.menuItem[0],
        onChanged: (answerValue) {
          widget.onAnswer(answerValue.toString());
        },
        items: widget.menuItem.map(
          (e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          },
        ).toList(),
      ),
    );
  }
}

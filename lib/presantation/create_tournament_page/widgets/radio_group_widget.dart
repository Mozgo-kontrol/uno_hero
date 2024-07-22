import 'package:flutter/material.dart';

class RadioGroupWidget extends StatelessWidget {
  final int selectedValue;
  final Function(int) onChanged;
  const RadioGroupWidget({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          height: constraints.maxHeight / 2,
          width: constraints.maxWidth*0.8,
          child: Row(
            children: [
              RadioListTile<int>(
                value: 0,
                groupValue: selectedValue,
                title: Text('Option 1'),
                onChanged: (value) => onChanged,
              ),
              RadioListTile<int>(
                value: 1,
                groupValue: selectedValue,
                title: Text('Option 2'),
                onChanged: (value) => onChanged,
              ),
              RadioListTile<int>(
                value: 2,
                groupValue: selectedValue,
                title: Text('Option 3'),
                onChanged: (value) => onChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}
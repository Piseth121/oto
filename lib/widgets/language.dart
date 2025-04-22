
import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
      ),
      body: ListView(
        children: [
          RadioListTile(
            title: Text('English'),
            value: 1,
            groupValue:
            _selectedValue, // Use _selectedValue to track the selected option
            onChanged: (value) {
              setState(() {
                _selectedValue =
                value!; // Update _selectedValue when option 1 is selected
              });
            },
          ),
          RadioListTile(
            title: Text('Khmer'),
            value: 2,
            groupValue:
            _selectedValue, // Use _selectedValue to track the selected option
            onChanged: (value) {
              setState(() {
                _selectedValue =
                value!; // Update _selectedValue when option 1 is selected
              });
            },
          ),
          RadioListTile(
            title: Text('Chinese'),
            value: 3,
            groupValue:
            _selectedValue, // Use _selectedValue to track the selected option
            onChanged: (value) {
              setState(() {
                _selectedValue =
                value!; // Update _selectedValue when option 1 is selected
              });
            },
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/data_model.dart';
import 'package:provider/provider.dart';

class TimeTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimeTextFieldState();
}

class TimeTextFieldState extends State<TimeTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = context.read<DataModel>().time.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter time..',
        ),
        onChanged: (String newText) {
          int _time = int.parse(newText);
          context.read<DataModel>().setTime(_time);
        }
    );
  }
}



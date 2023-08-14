import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/data_model.dart';
import 'hsv_picker.dart';

class ColorPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker> {
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() {
    Provider.of<DataModel>(context, listen: false).setColor(color);
  });

  void changeColors(List<Color> colors) => setState(() {
    Provider.of<DataModel>(context, listen: false).setColors(colors);
  });

  @override
  Widget build(BuildContext context) {
    return  HSVColorPickerExample(
      pickerColor: Provider.of<DataModel>(context, listen: false).currentColor,
      onColorChanged: changeColor,
      colorHistory: colorHistory,
      onHistoryChanged: changeColors
    );
  }
}
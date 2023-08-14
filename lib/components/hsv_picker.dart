import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPickerExample extends StatefulWidget {
  const HSVColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<HSVColorPickerExample> createState() => _HSVColorPickerExampleState();
}

class _HSVColorPickerExampleState extends State<HSVColorPickerExample> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [ColorLabelType.hsl, ColorLabelType.hsv];
  bool _displayHexInputBar = true;


  // Picker 4
  final textController =
  TextEditingController(text: '#2F19DB'); // The initial value can be provided directly to the controller.


  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: widget.pickerColor,
                  onColorChanged: widget.onColorChanged,
                  colorPickerWidth: 300,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: _enableAlpha,
                  labelTypes: _labelTypes,
                  displayThumbColor: _displayThumbColor,
                  paletteType: _paletteType,
                  pickerAreaBorderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                  hexInputBar: _displayHexInputBar,
                  colorHistory: widget.colorHistory,
                  onHistoryChanged: widget.onHistoryChanged,
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        primary: widget.pickerColor,
        shadowColor: widget.pickerColor.withOpacity(1),
        elevation: 10,
      ),
      child: Text(
        'Color Picker with Slider',
        style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
      ),
    );
  }
}
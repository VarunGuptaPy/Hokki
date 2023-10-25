import 'package:flutter/material.dart';

class SliderDialog extends StatefulWidget {
  final String? title;
  final String? writeBeforeValue;
  final VoidCallback? onCancel;
  final Function(double currentValue)? onDone;
  final double? max;
  final double? min;
  final int? diversion;
  final bool? showDeliverPrice;
  final int? deliveryPrice;
  SliderDialog({
    this.deliveryPrice,
    this.title,
    this.writeBeforeValue,
    this.onCancel,
    this.onDone,
    this.diversion,
    this.min,
    this.max,
    this.showDeliverPrice,
  });
  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title!),
      content: SizedBox(
        height: 100,
        child: Column(
          children: <Widget>[
            Text('${widget.writeBeforeValue!}: ${_currentSliderValue}'),
            widget.showDeliverPrice!
                ? Text(
                    'Deliver Price could be: ${_currentSliderValue * widget.deliveryPrice!}')
                : Container(),
            Slider(
              value: _currentSliderValue,
              min: widget.min!,
              max: widget.max!,
              divisions: widget.diversion!,
              label: _currentSliderValue.toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: widget.onCancel,
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            widget.onDone!(_currentSliderValue);
          },
        ),
      ],
    );
  }
}

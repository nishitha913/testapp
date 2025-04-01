import 'package:flutter/material.dart';

class DeviceControlScreen extends StatefulWidget {
  final String deviceName;

  DeviceControlScreen({required this.deviceName});

  @override
  _DeviceControlScreenState createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  bool isOn = false;
  double sliderValue = 0.5; // Example for brightness or temperature

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Power'),
              value: isOn,
              onChanged: (bool value) {
                setState(() {
                  isOn = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Adjust Settings'),
            Slider(
              value: sliderValue,
              onChanged: (double value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            // Add more controls as needed
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ActiveDevicesScreen extends StatefulWidget {
  @override
  _ActiveDevicesScreenState createState() => _ActiveDevicesScreenState();
}

class _ActiveDevicesScreenState extends State<ActiveDevicesScreen> {
  List<Map<String, dynamic>> activeDevices = [
    {'name': 'Device 1', 'icon': Icons.device_thermostat, 'isOn': true},
    {'name': 'Device 2', 'icon': Icons.devices_other, 'isOn': false},
    {'name': 'Device 3', 'icon': Icons.device_hub, 'isOn': true},
  ];

  void _addNewDevice(String deviceName, IconData deviceIcon) {
    setState(() {
      activeDevices.add({'name': deviceName, 'icon': deviceIcon, 'isOn': false});
    });
  }

  void _showAddDeviceDialog() {
    String newDeviceName = '';
    IconData? selectedIcon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Device'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Device Name'),
                onChanged: (value) {
                  newDeviceName = value;
                },
              ),
              DropdownButton<IconData>(
                hint: Text('Select Device Icon'),
                value: selectedIcon,
                onChanged: (IconData? newValue) {
                  setState(() {
                    selectedIcon = newValue;
                  });
                },
                items: [
                  Icons.device_thermostat,
                  Icons.devices_other,
                  Icons.device_hub,
                  Icons.tv,
                  Icons.lightbulb,
                ].map<DropdownMenuItem<IconData>>((IconData value) {
                  return DropdownMenuItem<IconData>(
                    value: value,
                    child: Icon(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                if (newDeviceName.isNotEmpty && selectedIcon != null) {
                  _addNewDevice(newDeviceName, selectedIcon!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: activeDevices.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            title: Text(activeDevices[index]['name']),
            secondary: Icon(activeDevices[index]['icon']),
            value: activeDevices[index]['isOn'],
            onChanged: (bool value) {
              setState(() {
                activeDevices[index]['isOn'] = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDeviceDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Device',
      ),
    );
  }
}

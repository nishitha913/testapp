import 'package:flutter/material.dart';
import 'active_devices_screen.dart';

class AllDevicesScreen extends StatefulWidget {
  @override
  _AllDevicesScreenState createState() => _AllDevicesScreenState();
}

class _AllDevicesScreenState extends State<AllDevicesScreen> {
  List<String> devices = [
    'Device 1',
    'Device 2',
    'Device 3',
    'Device 4',
    'Device 5',
  ];

  void _addNewDevice(String deviceName) {
    setState(() {
      devices.add(deviceName);
    });
  }

  void _showAddDeviceDialog() {
    String newDeviceName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Device'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Device Name'),
            onChanged: (value) {
              newDeviceName = value;
            },
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
                if (newDeviceName.isNotEmpty) {
                  _addNewDevice(newDeviceName);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All Devices'),
              Tab(text: 'Active Devices'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index]),
                  onTap: () {
                    // Navigate to device details or control screen
                  },
                );
              },
            ),
            ActiveDevicesScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddDeviceDialog,
          child: Icon(Icons.add),
          tooltip: 'Add New Device',
        ),
      ),
    );
  }
}

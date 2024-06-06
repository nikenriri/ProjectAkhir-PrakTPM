import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePage extends StatefulWidget {
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  String _currentTime = '';
  TimeZone? selectedTimeZone;
  late Future<void> _updateTimeFuture;

  @override
  void initState() {
    super.initState();
    // Start the clock update loop
    _updateTime();

    // Set default selectedTimeZone to WIB
    selectedTimeZone = timeZones[0];
    _updateTimeFuture = Future.value();
  }

  @override
  void dispose() {
    // Stop the clock update loop
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      if (selectedTimeZone != null) {
        _currentTime = DateFormat('HH:mm:ss').format(
          DateTime.now().toUtc().add(selectedTimeZone!.offset),
        );
      } else {
        _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      }
    });

    _updateTimeFuture = Future.delayed(Duration(seconds: 1), _updateTime);
  }

  void _selectTimeZone(TimeZone timeZone) {
    setState(() {
      selectedTimeZone = timeZone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Clock'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _currentTime,
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Select Time Zone:',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: timeZones.map((timeZone) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {
                    _selectTimeZone(timeZone);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTimeZone == timeZone ? Colors.teal : Colors.grey,
                  ),
                  child: Text(
                    timeZone.name,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TimeZone {
  final String name;
  final Duration offset;

  TimeZone(this.name, this.offset);
}

// List of example time zones
List<TimeZone> timeZones = [
  TimeZone('WIB', Duration(hours: 7)),
  TimeZone('WITA', Duration(hours: 8)),
  TimeZone('WIT', Duration(hours: 9)),
  TimeZone('London', Duration(hours: 1)),
];

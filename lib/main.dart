import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'models/widget_data.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String dataKey = 'widgetData';
  final String appGroupId = 'group.com.78sarmad';
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    WidgetKit.reloadAllTimelines();
    WidgetKit.reloadTimelines(dataKey);
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      textStyle: TextStyle(color: Colors.white),
      padding: const EdgeInsets.only(left: 20, right: 20),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Where\'s My Widget?'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: 'Enter text to render on Widget'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () {
                      WidgetKit.setItem(
                        dataKey,
                        jsonEncode(FlutterWidgetData(textController.text)),
                        appGroupId,
                      );
                      WidgetKit.reloadAllTimelines();
                    },
                    child: Text('Update'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () {
                      WidgetKit.removeItem(dataKey, appGroupId);
                      WidgetKit.reloadAllTimelines();
                      textController.clear();
                    },
                    child: Text('Remove'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

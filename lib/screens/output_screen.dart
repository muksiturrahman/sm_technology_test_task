import 'package:flutter/material.dart';
import 'package:sm_technology_test_task/utils/global_var.dart';
import '../models/android_version_model.dart';
import '../utils/json_parser.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({super.key});

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  final String input1 = AppString.input1;

  final String input2 = AppString.input2;

  List<AndroidVersion> parsedVersions = [];

  void parseAndDisplay(String jsonString) {
    setState(() {
      parsedVersions = JSONParser.parseJSON(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Parser'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => parseAndDisplay(input1),
                child: Text('Parse Input 1'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => parseAndDisplay(input2),
                child: Text('Parse Input 2'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: parsedVersions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(parsedVersions[index].title),
                  subtitle: Text('ID: ${parsedVersions[index].id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


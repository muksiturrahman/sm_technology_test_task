import 'package:flutter/material.dart';
import 'package:sm_technology_test_task/utils/global_var.dart';
import '../models/android_version_model.dart';
import '../utils/json_parser.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/background_container.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({super.key});

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen>
    with SingleTickerProviderStateMixin {
  final String input1 = AppString.input1;
  final String input2 = AppString.input2;

  late List<AndroidVersion> parsedVersionsInput1;
  late List<AndroidVersion> parsedVersionsInput2;
  late ValueNotifier<List<AndroidVersion>> currentParsedVersions;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    parsedVersionsInput1 = JSONParser.parseJSON(input1);
    parsedVersionsInput2 = JSONParser.parseJSON(input2);

    currentParsedVersions = ValueNotifier(parsedVersionsInput1);
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void displayParsedData(List<AndroidVersion> versions) {
    currentParsedVersions.value = versions;
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'JSON Parser'),
      body: BackgroundContainer(
        child: Column(
          children: [
            _buildButtonRow(),
            _buildParsedDataList(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => displayParsedData(parsedVersionsInput1),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
          child: const Text(
            'Parsed Data of Input 1',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => displayParsedData(parsedVersionsInput2),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
          child: const Text(
            'Parsed Data of Input 2',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildParsedDataList() {
    return Expanded(
      child: ValueListenableBuilder<List<AndroidVersion>>(
        valueListenable: currentParsedVersions,
        builder: (context, versions, child) {
          return ListView.builder(
            itemCount: versions.length,
            itemBuilder: (context, index) {
              final Animation<double> animation = CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  (1 / versions.length) * index,
                  1.0,
                  curve: Curves.easeOut,
                ),
              );
              return CustomListTile(
                version: versions[index],
                animation: animation,
              );
            },
          );
        },
      ),
    );
  }
}

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
      appBar: const CustomAppBar(title: 'JSON Parser'),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: ElevatedButton(
              onPressed: () => displayParsedData(parsedVersionsInput1),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                backgroundColor: Colors.teal.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                shadowColor: Colors.black,
                elevation: 10.0,
              ),
              child: const Text(
                'Parsed Data of Input 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: ElevatedButton(
              onPressed: () => displayParsedData(parsedVersionsInput2),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                backgroundColor: Colors.teal.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                shadowColor: Colors.black,
                elevation: 10.0,
              ),
              child: const Text(
                'Parsed Data of Input 2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParsedDataList() {
    return Expanded(
      child: ValueListenableBuilder<List<AndroidVersion>>(
        valueListenable: currentParsedVersions,
        builder: (context, versions, child) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomListTile(
                  version: versions[index],
                  animation: animation,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'dart:convert';

import '../models/android_version_model.dart';

class JSONParser {
  static List<AndroidVersion> parseJSON(String jsonString) {
    List<dynamic> jsonData = json.decode(jsonString);
    List<AndroidVersion> versions = [];

    for (var element in jsonData) {
      if (element is Map) {
        element.forEach((key, value) {
          versions.add(AndroidVersion(id: value['id'], title: value['title']));
        });
      } else if (element is List) {
        for (var item in element) {
          versions.add(AndroidVersion(id: item['id'], title: item['title']));
        }
      }
    }

    return versions;
  }
}

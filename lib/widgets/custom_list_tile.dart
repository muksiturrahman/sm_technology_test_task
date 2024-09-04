import 'package:flutter/material.dart';
import '../models/android_version_model.dart';

class CustomListTile extends StatelessWidget {
  final AndroidVersion version;
  final Animation<double> animation;

  const CustomListTile({
    required this.version,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(
          CurveTween(curve: Curves.easeInOut),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          elevation: 3.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              child: Text(
                version.id.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              version.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('ID: ${version.id}'),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
          ),
        ),
      ),
    );
  }
}

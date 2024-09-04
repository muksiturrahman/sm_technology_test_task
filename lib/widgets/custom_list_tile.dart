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
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.teal,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0,),
          leading: CircleAvatar(
            backgroundColor: Colors.teal.shade700,
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
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal.shade700),
        ),
      ),
    );
  }
}

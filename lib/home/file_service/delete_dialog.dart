import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;

  const DeleteDialog({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure to Delete"),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SubtaskTile extends StatelessWidget {
  final String subtaskTitle;
  final VoidCallback callback;

  const SubtaskTile({
    super.key,
    required this.subtaskTitle,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFFe8ecfd),
        borderRadius: BorderRadius.circular(16)
      ),
      child: ListTile(
        title: Text(subtaskTitle),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Color(0xFF5B67CA),
              shape: BoxShape.circle
            ),
          ),
        ),
        trailing: GestureDetector(
          onTap: (){
            callback();
          },
          child: Icon(Icons.delete_outline)
        ),
      ),
    );
  }
}
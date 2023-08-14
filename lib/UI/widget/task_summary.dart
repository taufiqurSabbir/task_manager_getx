import 'package:flutter/material.dart';

class Task_Summary extends StatefulWidget {
  const Task_Summary({
    super.key,
    required this.number,
    required this.title, required this.onUpdate,
  });

  final String number;
  final String title;
  final VoidCallback onUpdate;

  @override
  State<Task_Summary> createState() => _Task_SummaryState();
}

class _Task_SummaryState extends State<Task_Summary> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            widget.number !='null'
                ?
            Text(
              widget.number ,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            )

                :  const CircularProgressIndicator(),
            Text('${widget.title}')
          ],
        ),
      ),
    );
  }
}

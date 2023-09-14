import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class History extends StatefulWidget {
  String amount;
  String answer;
  History({Key? key, required this.amount, required this.answer})
      : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: widget.amount.length,
            itemBuilder: ((context, index) {
              return Center(
                child: Text(widget.amount),
              );
            })));
  }
}

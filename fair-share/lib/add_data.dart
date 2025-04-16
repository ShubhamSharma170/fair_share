import 'package:fair_share/providers/list_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddData extends StatelessWidget {
  const AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data")),
      body: Center(
        child: IconButton(
          onPressed: () {
            context.read<ListMapProvider>().addData({
              "name": "Shubham",
              "age": 20,
            });
          },
          icon: Icon(Icons.add),
        ),
      ),
      // body: Center(
      //   child: IconButton(
      //     onPressed: () {
      //       context.read<ListMapProvider>().addData({
      //         "name": "Shubham",
      //         "age": 20,
      //       });
      //     },
      //     icon: Icon(Icons.add),
      //   ),
      // ),
    );
  }
}

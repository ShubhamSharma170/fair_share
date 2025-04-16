import 'package:fair_share/add_data.dart';
import 'package:fair_share/providers/list_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMap extends StatelessWidget {
  const ListMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List Map",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Consumer<ListMapProvider>(
        builder: (ctx, provider, __) {
          // var data = provider.getList();
          var data = ctx.watch<ListMapProvider>().getList();
          return data.isEmpty
              ? Center(child: Text("No data found"))
              : ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text("${data[index]['name']}"),
                    subtitle: Text("${data[index]['age']}"),
                  );
                },
              );
        },
      ),
      // body: Consumer<ListMapProvider>(
      //   builder: (_, provider, __) {
      //     var data = provider.getList();
      //     return data.isNotEmpty
      //         ? ListView.builder(
      //           itemCount: data.length,
      //           itemBuilder: (_, index) {
      //             return ListTile(
      //               title: Text("name: ${data[index]['name']}"),
      //               subtitle: Text("age: ${data[index]['age']}"),
      //             );
      //           },
      //         )
      //         : Center(child: Text("No data"));
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<ListMapProvider>().addData({
          //   "name": "Shubham",
          //   "age": 20,
          // });
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

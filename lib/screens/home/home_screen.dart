// ignore_for_file: unused_local_variable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';
import 'package:fair_share/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: AllColors.purple0xFFC135E3,
      ),
      body: Column(
        children: [
          // todo (later add a row of search button)
          // list view builder show the group and non group expenses
          ListTile(
            title: Text("Non-Group Expenses"),
            subtitle: Text("Expense Name"),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.nonExpenses);
            },
          ),

          StreamBuilder(
            stream:
                FirebaseFirestore.instance
                    .collection("groupExpense")
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No expenses found.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    log(
                      "snapshot.data!.docs[index]: ${snapshot.data!.docs[index].id}",
                    );
                    return ListTile(
                      title: Text("${snapshot.data!.docs[index]['groupName']}"),
                      // subtitle: Text("Expense Name"),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.groupExpenses,
                          arguments: snapshot.data!.docs[index].id,
                        );
                      },
                    );
                  },
                );
              }
            },
          ),

          // SizedBox(
          //   height: 400,
          //   child: ListView.builder(
          //     itemCount: 7,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text("Group Name"),
          //         subtitle: Text("Expense Name"),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(height: 20),
          // Expanded(child: StreamBuilder(stream: stream, builder: builder)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.createGroup);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AllColors.black),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.group, size: 20),
                      SizedBox(width: 10),
                      Text("Start a new group", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        height: 70, // custom height
        width: 100,
        child: FloatingActionButton(
          backgroundColor: AllColors.purple0xFFC135E3,
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.addExpense);
            context.read<FirebaseMethodProvider>().showGroupNameList();
          },
          child: Text("Expenses", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

// ignore_for_file: unused_local_variable, unused_import, use_build_context_synchronously
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
    var borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(32),
      bottomLeft: Radius.circular(32),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen", style: TextStyle(color: Colors.white)),
        backgroundColor: AllColors.purple0xFFC135E3,
        actions: [
          IconButton(
            onPressed: () async {
              bool value =
                  await context.read<FirebaseMethodProvider>().logOut();
              if (value) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.signIn,
                  (route) => false,
                );
              }
            },
            icon: Icon(Icons.logout, color: AllColors.white),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Column(
          children: [
            // todo (later add a row of search button)
            // list view builder show the group and non group expenses
            ListTile(
              title: Text("Non-Group Expenses"),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              leading: Icon(Icons.group, color: AllColors.white),
              // subtitle: Text("Expense Name"),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              selectedTileColor: AllColors.grey,
              style: ListTileStyle.drawer,
              tileColor: AllColors.purple0xFFC135E3,
              onTap: () {
                Navigator.pushNamed(context, RoutesName.nonExpenses);
              },
            ),
            SizedBox(height: 10),
            Divider(color: AllColors.purple0xFFC135E3, thickness: 1),
            SizedBox(height: 10),
            SizedBox(
              child: Text(
                "Group Expenses",
                style: TextStyle(
                  color: AllColors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
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
                      // log(
                      //   "snapshot.data!.docs[index]: ${snapshot.data!.docs[index].id}",
                      // );
                      return Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          bottom: 10,
                        ),
                        child: ListTile(
                          title: Text(
                            "${snapshot.data!.docs[index]['groupName']}",
                          ),
                          titleTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          leading: Icon(Icons.group, color: AllColors.white),
                          // subtitle: Text("Expense Name"),
                          shape: RoundedRectangleBorder(
                            borderRadius: borderRadius,
                          ),
                          selectedTileColor: AllColors.grey,
                          style: ListTileStyle.drawer,
                          tileColor: AllColors.purple0xFFC135E3,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.groupExpenses,
                              arguments: snapshot.data!.docs[index].id,
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 20),
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
                      color: AllColors.purple0xFFC135E3,
                      border: Border.all(color: AllColors.purple0xFFC135E3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.group, size: 20, color: AllColors.white),
                        SizedBox(width: 10),
                        Text(
                          "Create a group",
                          style: TextStyle(
                            fontSize: 18,
                            color: AllColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          child: Text(
            "Expenses",
            style: TextStyle(fontSize: 18, color: AllColors.white),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unused_local_variable
import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

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

          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Group Name"),
                  subtitle: Text("Expense Name"),
                );
              },
            ),
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
          },
          child: Text("Expenses", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

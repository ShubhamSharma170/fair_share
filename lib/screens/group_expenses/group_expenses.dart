// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_share/constant/colors.dart';
import 'package:flutter/material.dart';

class GroupExpenses extends StatefulWidget {
  String? groupId;
  GroupExpenses({required this.groupId, super.key});

  @override
  State<GroupExpenses> createState() => _GroupExpensesState();
}

class _GroupExpensesState extends State<GroupExpenses> {
  // late String? groupId;
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments;
    log("args ${widget.groupId}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Expenses"),
        backgroundColor: AllColors.purple0xFFC135E3,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                        .collection('groupExpense')
                        .doc(widget.groupId)
                        .collection("expense")
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No expenses found.'));
                  } else {
                    final expenseDocs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: expenseDocs.length,
                      itemBuilder: (context, index) {
                        final expense = expenseDocs[index].data();
                        return ListTile(
                          title: Text(expense['amount']),
                          subtitle: Text(expense['description'].toString()),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

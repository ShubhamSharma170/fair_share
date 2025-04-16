import 'package:fair_share/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("build function called");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (ctx, _, __) {
                print("Consumer called");
                return Text(
                  "Counter value here: ${ctx.watch<CounterProvider>().getCounter()}",
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
            // Text("Counter value here: ${Provider.of<CounterProvider>(context).getCounter()}",style: TextStyle(fontSize: 30),),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.read<CounterProvider>().incrementEvent();
                // Provider.of<CounterProvider>(context,listen: false).incrementEvent();
              },
              child: Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlanningPage extends StatefulWidget {
  final String title;

  const PlanningPage({super.key, required this.title});

  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: FilledButton(
              onPressed: () {
                GoRouter.of(context).go("/selectpage");
              },
              child: Text(widget.title))),
    );
  }
}

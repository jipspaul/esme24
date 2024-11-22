import 'package:flutter/material.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/repositories/models/location.dart';

class SelectPage extends StatefulWidget {
  final String title;

  const SelectPage({super.key, required this.title});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  List<Location> plans = [];

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    List<Location> fetchedPlans = LocationManager().wantedLocations;
    setState(() {
      plans = fetchedPlans;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(plans[index].nom),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }
}

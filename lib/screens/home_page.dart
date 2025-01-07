import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/repositories/models/hive_tester.dart';
import 'package:swipezone/repositories/models/test_hive.dart';
import 'package:swipezone/screens/widgets/location_card.dart';
import 'dart:isolate';
import 'dart:async';
import 'package:swipezone/repositories/hive_adapter.dart';

import 'package:swipezone/theme/theme_provider.dart';

class IsolateMessage {
  final SendPort sendPort;
  IsolateMessage(this.sendPort);
}

void popupIsolate(IsolateMessage message) {
  final Timer periodicTimer = Timer.periodic(
    const Duration(seconds: 10),
    (timer) {
      message.sendPort.send('showPopup');
    },
  );
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ReceivePort? receivePort;

  @override
  void initState() {
    super.initState();
    startPopupIsolate();
  }

  void startPopupIsolate() async {
    // Create communication ports
    receivePort = ReceivePort();

    // Spawn the isolate
    await Isolate.spawn<IsolateMessage>(
      popupIsolate,
      IsolateMessage(receivePort!.sendPort),
    );

    // Listen for messages from the isolate
    receivePort!.listen((message) {
      if (message == 'showPopup') {
        //launchPopUpeach10sec(context);
      }
    });
  }

  @override
  void dispose() {
    receivePort?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: LocationUseCase().getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return Text("No data");
            }

            LocationManager().locations = data;

            return ListView(children: [
              LocationCard(location: data[LocationManager().currentIndex]),
              Center(
                child: Switch(
                  value: Provider.of<ThemeProvider>(context).getThemeMode() ==
                      ThemeMode.dark,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ),
              StreamBuilder(
                stream: TestHiveObject.listen(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var data = TestHiveObject.getAll();
                    return Column(
                      children: data
                          .map((e) => ListTile(
                                title: Text(e.name),
                                subtitle: Text(e.age.toString()),
                              ))
                          .toList(),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var randomName =
                        "test${DateTime.now().millisecondsSinceEpoch}";
                    var randomAge = DateTime.now().millisecondsSinceEpoch % 100;
                    await TestHiveObject.add(
                        TestHive(name: "test", age: randomAge));
                  },
                  child: const Text("Next"),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          LocationManager().Idontwant();
                        });
                      },
                      child: const Text("Nope"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          LocationManager().Iwant();
                        });
                      },
                      child: const Text("Yep"),
                    ),
                    Text(
                        "Don't like: ${LocationManager().unwantedLocations.length}",
                        style:
                            const TextStyle(color: Colors.red, fontSize: 20)),
                    Text("Like: ${LocationManager().filters.length}",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 20)),
                  ],
                ),
              ),
              Center(
                child: FilledButton(
                    onPressed: () {
                      GoRouter.of(context).go('/selectpage');
                    },
                    child: const Text("Create plan")),
              )
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> launchPopUpeach10sec(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 10));
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hello"),
          content: const Text("This is a popup"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

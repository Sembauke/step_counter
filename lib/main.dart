import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  runApp(const SteppApp());
}

class SteppApp extends StatelessWidget {
  const SteppApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(0x13, 0x13, 0x12, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
          title: Text(
            'Step Counter',
            style: TextStyle(
              color: Colors.orange[200],
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(0x1e, 0x1e, 0x1f, 1),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

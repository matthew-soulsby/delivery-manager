import 'package:delivery_manager_app/pages/customer_manager.dart';
import 'package:delivery_manager_app/pages/route_manager.dart';
import 'package:delivery_manager_app/pages/schedule_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DeliveryManager());
}

class DeliveryManager extends StatelessWidget {
  const DeliveryManager({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Manager',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const AppScaffold(),
    );
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.local_shipping),
            icon: Icon(Icons.local_shipping_outlined),
            label: "Today's Route",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.groups),
            icon: Icon(Icons.groups_outlined),
            label: 'Manage Customers',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.edit_calendar),
            icon: Icon(Icons.edit_calendar_outlined),
            label: 'Schedule Deliveries',
          ),
        ],
      ),
      body: <Widget>[
        const RouteManager(),
        const CustomerManager(),
        const ScheduleManager(),
      ][currentPageIndex],
    );
  }
}

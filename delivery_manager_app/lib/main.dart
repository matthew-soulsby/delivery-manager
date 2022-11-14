import 'package:delivery_manager_app/classes/customer.dart';
import 'package:delivery_manager_app/pages/customer_manager.dart';
import 'package:delivery_manager_app/pages/route_manager.dart';
import 'package:delivery_manager_app/pages/schedule_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(CustomerAdapter());
  runApp(const DeliveryManager());
}

class DeliveryManager extends StatelessWidget {
  const DeliveryManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Manager',
      theme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 0, 132, 255),
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
  final PageController _pageController = PageController();

  List<String> labelList = ['Deliveries', 'Customers', 'Reports'];

  List<Widget> pageList = [
    const RouteManager(),
    const CustomerManager(),
    const ScheduleManager(),
  ];

  int currentPageIndex = 0;

  void navigationItemSelected(int index) {
    setState(() {
      currentPageIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 350), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(labelList[currentPageIndex]),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pageList.length,
        itemBuilder: (BuildContext context, int index) {
          return pageList[index];
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          navigationItemSelected(index);
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.local_shipping),
            icon: const Icon(Icons.local_shipping_outlined),
            label: labelList[0],
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.groups),
            icon: const Icon(Icons.groups_outlined),
            label: labelList[1],
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.file_open),
            icon: const Icon(Icons.file_open_outlined),
            label: labelList[2],
          ),
        ],
      ),
    );
  }
}

import 'package:delivery_manager_app/classes/customer.dart';
import 'package:delivery_manager_app/classes/payment.dart';
import 'package:delivery_manager_app/classes/delivery_route.dart';
import 'package:delivery_manager_app/classes/item.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:delivery_manager_app/pages/customer_manager.dart';
import 'package:delivery_manager_app/pages/report_manager.dart';
import 'package:delivery_manager_app/pages/delivery_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.initFlutter();
  registerHiveAdapters();
  runApp(const DeliveryManagerApp());
}

void registerHiveAdapters() {
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(DeliveryAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(PaymentAdapter());
  Hive.registerAdapter(DeliveryRouteAdapter());
}

class DeliveryManagerApp extends StatelessWidget {
  const DeliveryManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
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

  bool _isPageViewAnimating = false;

  List<String> labelList = ['Deliveries', 'Customers', 'Reports'];

  List<Widget> pageList = [
    const DeliveryManager(),
    const CustomerManager(),
    const ReportManager(),
  ];

  int currentPageIndex = 0;

  void navigationItemSelected(int index) {
    _isPageViewAnimating = true;

    setState(() {
      currentPageIndex = index;
      _pageController
          .animateToPage(index,
              duration: const Duration(milliseconds: 350), curve: Curves.ease)
          .then((_) {
        _isPageViewAnimating = false;
      });
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
        onPageChanged: (index) {
          if (_isPageViewAnimating) return;
          setState(() {
            currentPageIndex = index;
          });
        },
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

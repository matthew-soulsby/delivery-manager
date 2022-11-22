import 'package:delivery_manager_app/classes/customer.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:delivery_manager_app/pages/customer_manager.dart';
import 'package:delivery_manager_app/pages/report_manager.dart';
import 'package:delivery_manager_app/pages/delivery_manager.dart';
import 'package:delivery_manager_app/themes/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

void main() async {
  final isar = await Isar.open([CustomerSchema, DeliverySchema]);
  runApp(DeliveryManagerApp(
    isar: isar,
  ));
}

class DeliveryManagerApp extends StatelessWidget {
  const DeliveryManagerApp({super.key, required this.isar});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    // Force portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Delivery Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: AppScaffold(isar: isar),
    );
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.isar});

  final Isar isar;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final PageController _pageController = PageController();

  bool _isPageViewAnimating = false;

  List<String> labelList = ['Deliveries', 'Customers', 'Reports'];

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
      body: PageView(
        onPageChanged: (index) {
          if (_isPageViewAnimating) return;
          setState(() {
            currentPageIndex = index;
          });
        },
        controller: _pageController,
        children: [
          DeliveryManager(isar: widget.isar),
          CustomerManager(isar: widget.isar),
          ReportManager(isar: widget.isar),
        ],
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

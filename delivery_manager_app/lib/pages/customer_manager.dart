import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/customer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerManager extends StatelessWidget {
  const CustomerManager({super.key});

  void addCustomer() {}

  void editCustomer() {}

  void deleteCustomer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox<Customer>('customers'),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: loadingSpinner(
                  text: 'Loading inbox...',
                  alignment: MainAxisAlignment.center,
                ),
              );
            }

            // If an error occurred, display it.
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              );
            }

            return ValueListenableBuilder<Box>(
              valueListenable: Hive.box<Customer>('customers').listenable(),
              builder: (context, box, widget) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text('No customers found'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Customer customer = box.getAt(index);
                      return ListTile(
                        title: Text(customer.name),
                        subtitle: Text(customer.getAddressShort()),
                      );
                    },
                  );
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

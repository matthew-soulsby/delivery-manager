import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/customer.dart';
import 'package:delivery_manager_app/forms/customer_add.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerManager extends StatelessWidget {
  const CustomerManager({super.key});

  void addCustomer(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CustomerAddScreen()));
  }

  void editCustomer(BuildContext context, int customerId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerAddScreen(
                  id: customerId,
                )));
  }

  void deleteCustomer(Box<dynamic> box, int customerId) {
    box.delete(customerId);
  }

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
                      return Card(
                        child: ListTile(
                          title: Text(customer.name),
                          subtitle: Text(customer.getAddressShort()),
                          trailing: PopupMenuButton<String>(
                              // Callback that sets the selected popup menu item.
                              onSelected: (String option) {
                                switch (option) {
                                  case 'Edit':
                                    editCustomer(context, customer.key);
                                    break;
                                  case 'Delete':
                                    deleteCustomer(box, customer.key);
                                    break;
                                  default:
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'Edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'Delete',
                                      child: Text('Delete'),
                                    ),
                                  ]),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addCustomer(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

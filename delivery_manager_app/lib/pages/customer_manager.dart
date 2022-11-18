import 'package:delivery_manager_app/assets/loading_spinner.dart';
import 'package:delivery_manager_app/classes/customer.dart';
import 'package:delivery_manager_app/pages/customer/customer_form.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class CustomerManager extends StatefulWidget {
  const CustomerManager({super.key, required this.isar});

  final Isar isar;

  @override
  State<CustomerManager> createState() => _CustomerManagerState();
}

class _CustomerManagerState extends State<CustomerManager> {
  List<Customer> _customerList = [];

  void addCustomer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerFormScreen(isar: widget.isar),
      ),
    );
  }

  void editCustomer(BuildContext context, int customerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerFormScreen(
          id: customerId,
          isar: widget.isar,
        ),
      ),
    );
  }

  void deleteCustomer(BuildContext context, int customerId) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete customer'),
        content: const Text('Are you sure? Deleting a customer is permanent.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.isar.writeTxn(() async {
                await widget.isar.customers.delete(customerId);
              });
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void refreshCustomerList() {
    if (!mounted) return;

    widget.isar.customers.where().findAll().then((newList) {
      setState(() {
        _customerList = newList;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    refreshCustomerList();

    Stream<void> customersChanged = widget.isar.customers.watchLazy();
    customersChanged.listen((value) {
      refreshCustomerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_customerList.isEmpty)
          ? const Center(
              child: Text('No customers found'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _customerList.length,
              itemBuilder: (context, index) {
                Customer customer = _customerList[index];

                return Card(
                  child: ListTile(
                    title: Text(customer.name ?? ''),
                    subtitle: Text(customer.getAddressShort()),
                    trailing: Theme(
                        data: Theme.of(context).copyWith(useMaterial3: false),
                        child: PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // Callback that sets the selected popup menu item.
                            onSelected: (String option) {
                              switch (option) {
                                case 'Edit':
                                  editCustomer(context, customer.id ?? 0);
                                  break;
                                case 'Delete':
                                  deleteCustomer(context, customer.id ?? 0);
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
                                ])),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: getPrimaryColors(context)[0],
        foregroundColor: getPrimaryColors(context)[1],
        onPressed: () => addCustomer(context),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

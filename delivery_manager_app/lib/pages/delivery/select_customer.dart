import 'package:delivery_manager_app/classes/customer.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class SelectCustomer extends StatefulWidget {
  const SelectCustomer({super.key, required this.isar});

  final Isar isar;

  @override
  State<SelectCustomer> createState() => _SelectCustomerState();
}

class _SelectCustomerState extends State<SelectCustomer> {
  List<Customer> _customerList = [];

  String _searchString = '';

  void popCustomer(BuildContext context, Customer customer) {
    Navigator.pop(
      context,
      customer,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Customer'),
      ),
      body: (_customerList.isEmpty)
          ? const Center(
              child: Text('No customers found'),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _searchString,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      helperText: "Enter customer's name or address",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.search_rounded),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _searchString = value.toLowerCase();
                        });
                      }
                    },
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _customerList.length,
                  itemBuilder: (context, index) {
                    Customer customer = _customerList[index];
                    if (customer.name!.toLowerCase().contains(_searchString) ||
                        customer
                            .getAddressShort()
                            .toLowerCase()
                            .contains(_searchString)) {
                      return Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: ListTile(
                          title: Text(customer.name ?? ''),
                          subtitle: Text(customer.getAddressShort()),
                          trailing: Theme(
                            data:
                                Theme.of(context).copyWith(useMaterial3: false),
                            child: TextButton(
                              child: const Icon(Icons.done_rounded),
                              onPressed: () {
                                popCustomer(context, customer);
                              },
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
    );
  }
}

import 'package:delivery_manager_app/classes/customer.dart';
import 'package:delivery_manager_app/classes/delivery.dart';
import 'package:delivery_manager_app/classes/item.dart';
import 'package:delivery_manager_app/pages/delivery/item_form.dart';
import 'package:delivery_manager_app/pages/delivery/select_customer.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:delivery_manager_app/util/price_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class DeliveryFormScreen extends StatefulWidget {
  const DeliveryFormScreen({super.key, this.delivery, required this.isar});

  final Delivery? delivery;
  final Isar isar;

  @override
  State<DeliveryFormScreen> createState() => _DeliveryFormScreenState();
}

class _DeliveryFormScreenState extends State<DeliveryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateInputController = TextEditingController();

  String _pageTitle = 'New Delivery';

  DateTime? _date;
  Recurrance? _recurrance;
  List<Item> _itemsToDeliver = [];
  Customer? _selectedCustomer;

  void submitForm(Delivery? delivery) async {
    if (_selectedCustomer == null) {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text('Error'),
          content: Text('You must select a customer to continue.'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      (delivery == null) ? addDelivery() : editDelivery(delivery);
    }
  }

  void addItem() async {
    Item? newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ItemFormScreen(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _itemsToDeliver.add(newItem);
    });
  }

  void editItem(Item item, int index) async {
    Item? editedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemFormScreen(
          item: item,
        ),
      ),
    );

    if (editedItem == null) {
      return;
    }

    setState(() {
      _itemsToDeliver[index] = editedItem;
    });
  }

  void deleteItem(int index) {
    setState(() {
      _itemsToDeliver.remove(_itemsToDeliver[index]);
    });
  }

  void selectCustomer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectCustomer(isar: widget.isar),
      ),
    ).then((poppedCustomer) {
      if (poppedCustomer != null) {
        setState(() {
          _selectedCustomer = poppedCustomer;
        });
      }
    });
  }

  void addDelivery() async {
    final delivery = Delivery()
      ..date = _date
      ..recurrance = _recurrance
      ..itemsToDeliver = _itemsToDeliver
      ..customer.value = _selectedCustomer;

    widget.isar.writeTxn(() async {
      await widget.isar.deliverys.put(delivery);
      await delivery.customer.save();
    }).then((value) => Navigator.pop(context));
  }

  void editDelivery(Delivery delivery) {
    delivery
      ..date = _date
      ..recurrance = _recurrance
      ..itemsToDeliver = _itemsToDeliver
      ..customer.value = _selectedCustomer;

    widget.isar.writeTxn(() async {
      await widget.isar.deliverys.put(delivery);
      await delivery.customer.save();
    }).then((value) => Navigator.pop(context));
  }

  @override
  void initState() {
    super.initState();

    if (widget.delivery != null) {
      _pageTitle = 'Edit Delivery';

      _date = widget.delivery?.date ?? DateTime.now();
      dateInputController.text =
          DateFormat('dd-MM-yyyy').format(_date ?? DateTime.now());
      _recurrance = widget.delivery?.recurrance;
      _itemsToDeliver = widget.delivery?.itemsToDeliver.toList() ?? [];
      _selectedCustomer = widget.delivery?.customer.value;
    }
  }

  @override
  void dispose() {
    dateInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)?.save();
        },
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: dateInputController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_today_rounded,
                  ),
                  labelText: 'Delivery Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)));

                  if (selectedDate != null) {
                    setState(() {
                      _date = selectedDate;
                      dateInputController.text =
                          DateFormat('dd-MM-yyyy').format(selectedDate);
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Recurrance>(
                value: _recurrance,
                items: const [
                  DropdownMenuItem<Recurrance>(
                    value: null,
                    child: Text('Once off'),
                  ),
                  DropdownMenuItem<Recurrance>(
                    value: Recurrance.everyWeek,
                    child: Text('Every week'),
                  ),
                  DropdownMenuItem<Recurrance>(
                      value: Recurrance.everySecondWeek,
                      child: Text('Every second week')),
                  DropdownMenuItem<Recurrance>(
                      value: Recurrance.everyThirdWeek,
                      child: Text('Every third week')),
                  DropdownMenuItem<Recurrance>(
                      value: Recurrance.everyFourthWeek,
                      child: Text('Every fourth week')),
                ],
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.event_repeat_rounded,
                    ),
                    labelText: 'Schedule to occur:',
                    border: OutlineInputBorder()),
                onChanged: (value) => {
                  if (value != null)
                    {
                      setState(() {
                        _recurrance = value;
                      })
                    }
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delivering to:'),
                      Text(_selectedCustomer?.name ?? 'No customer selected'),
                      Text(_selectedCustomer?.getAddressShort() ?? ''),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      selectCustomer();
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Select Customer'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Items to deliver:'),
                      OutlinedButton.icon(
                        onPressed: () async {
                          addItem();
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add Item'),
                      )
                    ],
                  ),
                  (_itemsToDeliver.isEmpty)
                      ? const Text('No items to deliver')
                      : Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: _itemsToDeliver.length,
                              itemBuilder: (context, index) {
                                Item item = _itemsToDeliver[index];

                                return Card(
                                  elevation: 0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  child: ListTile(
                                    title: Text(item.name ?? ''),
                                    subtitle:
                                        Text(formatPrice(item.priceCents ?? 0)),
                                    trailing: Theme(
                                      data: Theme.of(context)
                                          .copyWith(useMaterial3: false),
                                      child: PopupMenuButton<String>(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // Callback that sets the selected popup menu item.
                                        onSelected: (String option) {
                                          switch (option) {
                                            case 'Edit':
                                              editItem(item, index);
                                              break;
                                            case 'Delete':
                                              deleteItem(index);
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
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total:'),
                                Text(formatPrice(getTotal(_itemsToDeliver)))
                              ],
                            )
                          ],
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton(
              style: filledButtonPrimary(context),
              onPressed: () => submitForm(widget.delivery),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Submit'),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.send_rounded,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:delivery_manager_app/classes/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({super.key, this.id});

  final int? id;

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  var box = Hive.box<Customer>('customers');

  final _formKey = GlobalKey<FormState>();

  String _pageTitle = 'Add Customer';

  String _name = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _suburb = '';
  String _stateTerritory = 'VIC';
  int _postcode = 0;

  void submitForm(int? id) {
    if (_formKey.currentState!.validate()) {
      (id == null) ? addCustomer() : editCustomer(id);
    }
  }

  void addCustomer() {
    Future<int> value = (_addressLine2 == ''
        ? box.add(Customer(
            name: _name,
            addressLine1: _addressLine1,
            suburb: _suburb,
            stateTerritory: _stateTerritory,
            postcode: _postcode))
        : box.add(Customer(
            name: _name,
            addressLine1: _addressLine1,
            suburb: _suburb,
            stateTerritory: _stateTerritory,
            postcode: _postcode,
            addressLine2: _addressLine2)));

    value.then((value) => Navigator.pop(context));
  }

  void editCustomer(int id) {
    Future<void> value = (_addressLine2 == ''
        ? box.put(
            id,
            Customer(
                name: _name,
                addressLine1: _addressLine1,
                suburb: _suburb,
                stateTerritory: _stateTerritory,
                postcode: _postcode))
        : box.put(
            id,
            Customer(
                name: _name,
                addressLine1: _addressLine1,
                suburb: _suburb,
                stateTerritory: _stateTerritory,
                postcode: _postcode,
                addressLine2: _addressLine2)));

    value.then((value) => Navigator.pop(context));
  }

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      Customer? editCustomer = box.get(widget.id);
      _pageTitle = 'Edit Customer';

      _name = editCustomer?.name ?? '';
      _addressLine1 = editCustomer?.addressLine1 ?? '';
      _addressLine2 = editCustomer?.addressLine2 ?? '';
      _suburb = editCustomer?.suburb ?? '';
      _stateTerritory = editCustomer?.stateTerritory ?? '';
      _postcode = editCustomer?.postcode ?? 0;
    }
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    helperText: "Enter customer's full name",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null) {
                    setState(() {
                      _name = value;
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter customer's name";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _addressLine1,
                decoration: const InputDecoration(
                    labelText: 'Address Line 1',
                    helperText: "Enter house number & street name",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null) {
                    setState(() {
                      _addressLine1 = value;
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address line 1';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _addressLine2,
                decoration: const InputDecoration(
                    labelText: 'Address Line 2',
                    helperText:
                        "Enter unit, building, floor or other extra info",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null) {
                    setState(() {
                      _addressLine2 = value;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _suburb,
                decoration: const InputDecoration(
                    labelText: 'Suburb',
                    helperText: "Enter suburb",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null) {
                    setState(() {
                      _suburb = value;
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter suburb';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                value: _stateTerritory,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'VIC',
                    child: Text('VIC'),
                  ),
                  DropdownMenuItem<String>(value: 'NSW', child: Text('NSW')),
                  DropdownMenuItem<String>(value: 'QLD', child: Text('QLD')),
                  DropdownMenuItem<String>(value: 'SA', child: Text('SA')),
                  DropdownMenuItem<String>(value: 'WA', child: Text('WA')),
                  DropdownMenuItem<String>(value: 'TAS', child: Text('TAS')),
                  DropdownMenuItem<String>(value: 'NT', child: Text('NT')),
                  DropdownMenuItem<String>(value: 'ACT', child: Text('ACT')),
                ],
                decoration: const InputDecoration(
                    labelText: 'State/Territory', border: OutlineInputBorder()),
                onChanged: (value) => {
                  if (value != null)
                    {
                      setState(() {
                        _stateTerritory = value;
                      })
                    }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: (_postcode == 0) ? '' : _postcode.toString(),
                decoration: const InputDecoration(
                    labelText: 'Postcode',
                    helperText: "Enter postcode",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null && value != '') {
                    setState(() {
                      _postcode = int.parse(value);
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter postcode';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            TextButton(
              style: filledButtonPrimary(context),
              onPressed: () => submitForm(widget.id),
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

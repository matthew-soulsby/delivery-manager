import 'package:delivery_manager_app/classes/customer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomerAddScreen extends StatefulWidget {
  const CustomerAddScreen({super.key});

  @override
  State<CustomerAddScreen> createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  String _name = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _suburb = '';
  String _stateTerritory = 'VIC';
  int _postcode = 0;

  void submitForm() {
    var box = Hive.box<Customer>('customers');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
      ),
      body: Form(
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
                      labelText: 'State/Territory',
                      border: OutlineInputBorder()),
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
                  initialValue: _postcode.toString(),
                  decoration: const InputDecoration(
                      labelText: 'Postcode',
                      helperText: "Enter postcode",
                      border: OutlineInputBorder()),
                  onSaved: (String? value) {
                    if (value != null) {
                      setState(() {
                        _postcode = int.parse(value);
                      });
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => submitForm(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('SUBMIT'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.send,
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}

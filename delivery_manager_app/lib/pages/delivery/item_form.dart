import 'package:delivery_manager_app/classes/item.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:delivery_manager_app/classes/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

class ItemFormScreen extends StatefulWidget {
  const ItemFormScreen({super.key, this.item});

  final Item? item;

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _pageTitle = 'Add Item';

  String _name = '';
  String _itemPLU = '';
  String _barcode = '';
  int _priceCents = 0;

  void submitForm(Item? item) {
    if (_formKey.currentState!.validate()) {
      (item == null) ? addItem() : editItem();
    }
  }

  void addItem() {
    Navigator.pop(
        context,
        Item()
          ..name = _name
          ..priceCents = _priceCents
          ..itemPLU = _itemPLU.isNotEmpty ? _itemPLU : null
          ..barcode = _barcode.isNotEmpty ? _barcode : null);
  }

  void editItem() {
    Navigator.pop(
        context,
        Item()
          ..name = _name
          ..priceCents = _priceCents
          ..itemPLU = _itemPLU.isNotEmpty ? _itemPLU : null
          ..barcode = _barcode.isNotEmpty ? _barcode : null);
  }

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _pageTitle = 'Edit Item';

      _name = widget.item?.name ?? '';
      _itemPLU = widget.item?.itemPLU ?? '';
      _barcode = widget.item?.barcode ?? '';
      _priceCents = widget.item?.priceCents ?? 0;
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
                    labelText: 'Item Name',
                    helperText: "Enter item name",
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
                initialValue: _itemPLU,
                decoration: const InputDecoration(
                    labelText: 'Item PLU',
                    helperText: "Enter item's PLU (optional)",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null) {
                    setState(() {
                      _itemPLU = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _barcode,
                decoration: const InputDecoration(
                    labelText: 'Barcode',
                    helperText: "Enter item's barcode number (optional)",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null) {
                    setState(() {
                      _barcode = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: (_priceCents == 0) ? '' : _priceCents.toString(),
                decoration: const InputDecoration(
                    labelText: 'Price',
                    helperText: "Enter item's price",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null && value != '') {
                    setState(() {
                      _priceCents = int.parse(value);
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    // TODO: Make price format properly
                    return 'Please enter price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            TextButton(
              style: filledButtonPrimary(context),
              onPressed: () => submitForm(widget.item),
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

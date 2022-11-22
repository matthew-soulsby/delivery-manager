import 'package:delivery_manager_app/classes/item.dart';
import 'package:delivery_manager_app/themes/button_style.dart';
import 'package:delivery_manager_app/util/price_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemFormScreen extends StatefulWidget {
  const ItemFormScreen({super.key, this.item});

  final Item? item;

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceInputController =
      TextEditingController(text: formatPrice(0));

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

      priceInputController.text = formatPrice(_priceCents);
    }

    priceInputController.addListener(() {
      // Prune non-numeric chars and convert to int
      final int unformattedInput = parsePrice(priceInputController.text);
      // Format the new value with correct formatting
      final String formattedInput = formatPrice(unformattedInput);
      // Update the text field
      priceInputController.value = priceInputController.value.copyWith(
        text: formattedInput,
        selection: TextSelection(
            baseOffset: formattedInput.length,
            extentOffset: formattedInput.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    priceInputController.dispose();
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
                controller: priceInputController,
                decoration: const InputDecoration(
                    labelText: 'Price',
                    helperText: "Enter item's price",
                    border: OutlineInputBorder()),
                onSaved: (String? value) {
                  if (value != null && value != '') {
                    final unformattedPrice = parsePrice(value);
                    setState(() {
                      _priceCents = unformattedPrice;
                    });
                  }
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
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

import 'package:flutter/material.dart';
import 'package:crud_flutter/src/utils/utils.dart' as utils;
import 'package:crud_flutter/src/models/product_model.dart';

class ProductPage extends StatefulWidget {
  static final routeName = 'product';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  Product _product = new Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _inputName(),
                _inputPrice(),
                _inputAvailable(),
                SizedBox(height: 30.0),
                _saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputName() {
    return TextFormField(
      initialValue: _product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => _product.title = value,
      validator: (value) {
        return value.length >= 3 ? null : 'Ingrese el nombre del producto';
      },
    );
  }

  Widget _inputPrice() {
    return TextFormField(
      initialValue: _product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => _product.price = double.parse(value),
      validator: (value) {
        return utils.isNumeric(value) ? null : 'Sólo se permiten números';
      },
    );
  }

  Widget _inputAvailable() {
    return SwitchListTile(
      value: _product.available,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        _product.available = value;
      }),
    );
  }

  Widget _saveButton() {
    return RaisedButton.icon(
      label: Text('Guardar'),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onPressed: _submit,
    );
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      print('Formulario válido');
      print(_product.title);
      print(_product.price);
      print(_product.available);
    }
  }
}

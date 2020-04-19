import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crud_flutter/src/utils/utils.dart' as utils;
import 'package:crud_flutter/src/providers/products_provider.dart';

class ProductPage extends StatefulWidget {
  static final routeName = 'product';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = new ProducstProvider();
  Product product = new Product();
  bool _isLoading = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    final Product productData = ModalRoute.of(context).settings.arguments;

    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () => _selectImage(ImageSource.gallery),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _selectImage(ImageSource.camera),
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
                _showPhoto(),
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
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => product.title = value,
      validator: (value) {
        return value.length >= 3 ? null : 'Ingrese el nombre del producto';
      },
    );
  }

  Widget _inputPrice() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => product.price = double.parse(value),
      validator: (value) {
        return utils.isNumeric(value) ? null : 'Sólo se permiten números';
      },
    );
  }

  Widget _inputAvailable() {
    return SwitchListTile(
      value: product.available,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        product.available = value;
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
      onPressed: _isLoading ? null : _submit,
    );
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      if (product.id == null) {
        productProvider.createProduct(product);
      } else {
        productProvider.updateProduct(product);
      }

      showSnackbar('Producto guardado');

      Navigator.pop(context);
    }
  }

  showSnackbar(String msg) {
    final snackbar = SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showPhoto() {
    if (product.photo != null) {
      return Container();
    } else {
      return Image(
        image: photo?.path != null
            ? FileImage(photo)
            : AssetImage('assets/images/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void _selectImage(ImageSource source) async {
    photo = await ImagePicker.pickImage(
      source: source,
    );

    if (photo != null) {}

    setState(() {});
  }
}

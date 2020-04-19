import 'dart:io';

import 'package:crud_flutter/src/blocs/provider.dart';
import 'package:crud_flutter/src/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crud_flutter/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  static final routeName = 'product';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductsBloc productsBloc;
  Product product = new Product();
  bool _isLoading = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.productsBloc(context);
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

  _submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      if (photo != null) {
        product.photo = await productsBloc.uploadImage(photo);
      }

      if (product.id == null) {
        productsBloc.createProduct(product);
      } else {
        productsBloc.updateProduct(product);
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
      return FadeInImage(
        image: NetworkImage(product.photo),
        placeholder: AssetImage('assets/images/loading.gif'),
        height: 300.0,
        width: double.infinity,
        fit: BoxFit.contain,
      );
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

    if (photo != null) {
      product.photo = null;
    }

    setState(() {});
  }
}

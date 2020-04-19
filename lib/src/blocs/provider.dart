import 'package:flutter/material.dart';

import 'package:crud_flutter/src/blocs/login_bloc.dart';
export 'package:crud_flutter/src/blocs/login_bloc.dart';

import 'package:crud_flutter/src/blocs/products_bloc.dart';
export 'package:crud_flutter/src/blocs/products_bloc.dart';

class Provider extends InheritedWidget {
  final _loginBloc = new LoginBloc();
  final _productsBloc = new ProductsBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._(key: key, child: child);
    }

    return _instance;
  }

  Provider._({Key key, Widget child}) : super(key: key, child: child);

  // Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static ProductsBloc productsBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
}

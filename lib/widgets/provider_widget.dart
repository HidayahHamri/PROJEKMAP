import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }
}
// static Name of(BuildContext context) {
//   return context.dependOnInheritedWidgetOfExactType<Name>();  //after
// }

//   static Provider of(BuildContext context) =>
//       (context.inheritFromWidgetOfExactType(Provider) as Provider);
// }

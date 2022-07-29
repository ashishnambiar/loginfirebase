import 'package:flutter/material.dart';

snackBarHandler(BuildContext context, SnackBar snack) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

import 'package:flutter/material.dart';

class GlobalMethods {
  static navigateTo({required ctx, required name}) {
    Navigator.pushNamed(ctx, name);
  }
}

import 'package:flutter/material.dart';

class CustomLoadIndicator extends StatelessWidget {
  final double? setWidth;
  final double? setHeight;
  const CustomLoadIndicator({super.key, this.setWidth, this.setHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: setWidth ?? 0,
        height: setHeight ?? 0,
        color: const Color.fromARGB(94, 255, 255, 255),
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

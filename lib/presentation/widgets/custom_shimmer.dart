import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Gradient gradient;

  const CustomShimmer({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [
        Colors.grey,
        Colors.white,
        Colors.grey,
      ],
      stops: [0.3, 0.5, 0.7],
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: gradient.colors[0],
        highlightColor: gradient.colors[1],
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  final double triangleHeight;
  final double triangleWidth;
  MyCustomClipper({required this.triangleHeight, required this.triangleWidth});
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double triangleStart = size.width - triangleWidth - 15;

    // Define the border radius
    const double borderRadius = 8.0;

    // Start path with rounded corners
    path.addRRect(RRect.fromLTRBAndCorners(
      0, // Left
      triangleHeight, // Top (below the triangle)
      size.width, // Right
      size.height, // Bottom
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
    ));

    // Add the triangle at the top
    path.moveTo(triangleStart, triangleHeight); // Triangle base start
    path.lineTo(triangleStart + (triangleWidth / 2), 0); // Triangle peak
    path.lineTo(
        triangleStart + triangleWidth, triangleHeight); // Triangle base end
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

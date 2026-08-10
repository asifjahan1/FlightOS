import 'package:flutter/material.dart';

/// A utility widget that provides responsive layout capabilities
/// based on the available screen width.
///
/// It categorizes screens into:
/// - Phone (< 600 dp)
/// - Small Tablet (>= 600 dp and < 900 dp)
/// - Large Tablet / Desktop (>= 900 dp)
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.phone,
    this.smallTablet,
    this.largeTablet,
  });

  final Widget phone;
  final Widget? smallTablet;
  final Widget? largeTablet;

  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isSmallTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 900;

  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;

  static bool isAnyTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return largeTablet ?? smallTablet ?? phone;
        }
        if (constraints.maxWidth >= 600) {
          return smallTablet ?? largeTablet ?? phone;
        }
        return phone;
      },
    );
  }
}

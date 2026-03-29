import 'package:flutter/material.dart';

/// Centralized responsive breakpoints for the app.
///
/// Mobile  : width < 600
/// Tablet  : 600 ≤ width < 1024
/// Desktop : width ≥ 1024
class ResponsiveHelper {
  static const double _mobileBreakpoint = 600;
  static const double _desktopBreakpoint = 1024;
  static const double maxContentWidth = 1200;

  /// True for phone-sized screens (< 600px)
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < _mobileBreakpoint;

  /// True for tablet-sized screens (600 – 1023px)
  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= _mobileBreakpoint && w < _desktopBreakpoint;
  }

  /// True for desktop / laptop screens (≥ 1024px)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= _desktopBreakpoint;

  /// Variant that works inside [LayoutBuilder] / [BoxConstraints]
  static bool isMobileWidth(double width) => width < _mobileBreakpoint;
  static bool isTabletWidth(double width) =>
      width >= _mobileBreakpoint && width < _desktopBreakpoint;
  static bool isDesktopWidth(double width) => width >= _desktopBreakpoint;

  /// Returns a responsive column count for grid layouts.
  ///
  /// [mobileCount]  — number of columns on mobile (default 2)
  /// [tabletCount]  — number of columns on tablet (default 3)
  /// [desktopCount] — number of columns on desktop (default 4)
  static int gridCrossAxisCount(
    double width, {
    int mobileCount = 2,
    int tabletCount = 3,
    int desktopCount = 4,
  }) {
    if (width >= _desktopBreakpoint) return desktopCount;
    if (width >= _mobileBreakpoint) return tabletCount;
    return mobileCount;
  }

  /// Symmetric horizontal padding tuned for each screen size.
  static EdgeInsets horizontalPadding(double width) {
    if (width >= _desktopBreakpoint) return const EdgeInsets.symmetric(horizontal: 40);
    if (width >= _mobileBreakpoint) return const EdgeInsets.symmetric(horizontal: 24);
    return const EdgeInsets.symmetric(horizontal: 16);
  }
}

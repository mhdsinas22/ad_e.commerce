import 'package:flutter/material.dart';

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final Widget itemBuilder;
  final double spacing;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    required this.itemBuilder,
    this.spacing = 16.0,
    this.scrollDirection = Axis.vertical,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              scrollDirection == Axis.vertical
                  ? EdgeInsets.only(
                    bottom: index == itemCount - 1 ? 0 : spacing,
                  )
                  : EdgeInsets.only(
                    right: index == itemCount - 1 ? 0 : spacing,
                  ),
          child: itemBuilder,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class SwipeDetectorWidget extends StatelessWidget {
  final Widget child;
  final void Function({required bool isSwipeToLeft}) onSwipe;

  const SwipeDetectorWidget({
    required this.child,
    required this.onSwipe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: child,
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final dx = details.velocity.pixelsPerSecond.dx;
    final bool isSwipeToLeft = dx <= -100;
    final bool isRightRight = dx >= 100;
    if (isSwipeToLeft) {
      onSwipe(isSwipeToLeft: true);
    } else if (isRightRight) {
      onSwipe(isSwipeToLeft: false);
    }
  }
}

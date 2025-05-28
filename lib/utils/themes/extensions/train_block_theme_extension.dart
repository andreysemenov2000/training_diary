import 'package:flutter/material.dart';
import 'package:training_diary/utils/themes/colors.dart';

class TrainBlockThemeExtension extends ThemeExtension<TrainBlockThemeExtension> {
  BoxDecoration getTrainBlockBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: highlightColor,
    );
  }

  @override
  ThemeExtension<TrainBlockThemeExtension> copyWith() {
    return TrainBlockThemeExtension();
  }

  @override
  ThemeExtension<TrainBlockThemeExtension> lerp(
    covariant ThemeExtension<TrainBlockThemeExtension>? other,
    double t,
  ) {
    return TrainBlockThemeExtension();
  }
}

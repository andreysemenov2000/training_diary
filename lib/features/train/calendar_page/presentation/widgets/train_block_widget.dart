import 'package:flutter/material.dart';
import 'package:training_diary/utils/themes/extensions/train_block_theme_extension.dart';

class TrainBlockWidget extends StatelessWidget {
  final String name;

  const TrainBlockWidget({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trainBlockThemeExtension = theme.extension<TrainBlockThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 23,
        vertical: 25,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      height: 74,
      decoration: trainBlockThemeExtension.getTrainBlockBoxDecoration(),
      child: Row(
        children: [
          Text(
            name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

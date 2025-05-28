import 'package:flutter/material.dart';

class StartTrainButtonWidget extends StatelessWidget {
  const StartTrainButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: const Text('Начать тренировку'),
    );
  }

}

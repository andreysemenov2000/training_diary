import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateTrainPage extends StatelessWidget {
  static const _borderColor = Color(0xffC0C0C0);

  const CreateTrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        flexibleSpace: const Center(child: Text('Название тренировки')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSwitcher(context),
            const SizedBox(height: 29),
            _buildAddTemplateButton(context),
            _buildTemplateList(),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('Начать тренировку'),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSwitcher(BuildContext context) {
    const radius = 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: _borderColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: const Center(
                  child: Text(
                    'Упражнения',
                    style: TextStyle(
                      color: Color(0xff787878),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                color: _borderColor,
                child: const Center(
                  child: Text(
                    'Шаблон',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddTemplateButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        GoRouter.of(context).go('/train/details');
      },
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _borderColor),
        ),
        child: const Row(
          children: [
            Text(
              'Добавить шаблон',
              style: TextStyle(
                color: Color(0xff787878),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Spacer(),
            Icon(
              Icons.add,
              color: Color(0xff787878),
              size: 34,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateList() {
    return Container();
  }
}

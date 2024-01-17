import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class ScoreGrid extends StatelessWidget {
  const ScoreGrid({
    super.key,
    required this.successAttempts,
    required this.failedAttempts,
  });

  final int successAttempts;
  final int failedAttempts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ScoreGridItem(
          score: successAttempts + failedAttempts,
          title: 'Total',
        ),
        const SizedBox(
          width: 20.0,
        ),
        _ScoreGridItem(
          score: successAttempts,
          title: 'Success',
        ),
        const SizedBox(
          width: 20.0,
        ),
        _ScoreGridItem(
          score: failedAttempts,
          title: 'Failed',
        ),
      ],
    );
  }
}

class _ScoreGridItem extends StatelessWidget {
  const _ScoreGridItem({
    required this.score,
    required this.title,
  });

  final int score;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90.0,
        color: AppColors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColors.scaffold,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.0,
                color: AppColors.scaffold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

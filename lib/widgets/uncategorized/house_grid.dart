import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class HouseGrid extends StatelessWidget {
  const HouseGrid({
    super.key,
    required this.onTap,
  });

  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _HouseGridItem(
              title: 'Gryffindor',
              onTap: onTap,
            ),
            const SizedBox(
              width: 20.0,
            ),
            _HouseGridItem(
              title: 'Slytherin',
              onTap: onTap,
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            _HouseGridItem(
              title: 'Ravenclaw',
              onTap: onTap,
            ),
            const SizedBox(
              width: 20.0,
            ),
            _HouseGridItem(
              title: 'Hufflepuff',
              onTap: onTap,
            ),
          ],
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            _HouseGridItem(
              title: 'Not in House',
              onTap: (_) => onTap(null),
            ),
          ],
        ),
      ],
    );
  }
}

class _HouseGridItem extends StatelessWidget {
  const _HouseGridItem({
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(title),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 90.0,
          color: AppColors.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: AppColors.scaffold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

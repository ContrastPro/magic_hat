import 'package:flutter/material.dart';

import '../../models/uncategorized/custom_bottom_navigation_bar_item_model.dart';
import '../../resources/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentTab,
    required this.onSelect,
  });

  final int currentTab;
  final void Function(int) onSelect;

  final List<CustomBottomNavigationBarItemModel> _tabs = const [
    CustomBottomNavigationBarItemModel(
      icon: Icons.home_filled,
      title: 'Home',
    ),
    CustomBottomNavigationBarItemModel(
      icon: Icons.list_rounded,
      title: 'List',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: kBottomNavigationBarHeight,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom / 2,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _tabs.map((i) {
          final int index = _tabs.indexOf(i);

          return Flexible(
            child: SizedBox(
              width: double.infinity,
              height: kBottomNavigationBarHeight,
              child: InkWell(
                onTap: () => onSelect(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      i.icon,
                      color: index == currentTab
                          ? AppColors.secondary
                          : AppColors.primary,
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      i.title,
                      style: TextStyle(
                        color: index == currentTab
                            ? AppColors.secondary
                            : AppColors.primary,
                        fontSize: 11.0,
                        height: 1.18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

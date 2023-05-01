import 'package:flutter/material.dart';

import '../enums/home_bottom_tabs.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final HomeBottomTabs currentTab;
  final Function(HomeBottomTabs)? onTap;
  final tabs = HomeBottomTabs.values;

  const HomeBottomNavigationBar({
    required this.currentTab,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tabs.map((item) {
            return _BottomNavigationBarItem(
              tab: item,
              isSelected: currentTab == item,
              onSelected: () => onTap?.call(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _BottomNavigationBarItem extends StatelessWidget {
  final bool isSelected;
  final Function()? onSelected;
  final HomeBottomTabs tab;

  const _BottomNavigationBarItem({
    required this.tab,
    this.onSelected,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconOpacity = isSelected ? 1.0 : .76;

    return GestureDetector(
      onTap: onSelected,
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Icon(
              tab.icon,
              size: 24,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(iconOpacity),
            ),
          ),
          ClipRect(
            child: AnimatedAlign(
              alignment: Alignment.center,
              widthFactor: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              child: Text(
                tab.getLabelText(context),
                maxLines: 1,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      wordSpacing: -0.5,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

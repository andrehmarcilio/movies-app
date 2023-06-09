import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  final Widget icon;
  final String message;

  const EmptyPlaceholder({required this.icon, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Expanded(child: icon),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

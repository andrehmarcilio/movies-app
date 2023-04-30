import 'dart:math';

import 'package:flutter/material.dart';

import '../../support/style/app_assets.dart';

class SplashView extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> logoOpacity;
  final Animation<double> logoRotation;
  final Animation<Alignment> logoPosition;
  final Animation<double> backgroundContainerSizeFactor;

  SplashView({required this.controller, super.key})
      : backgroundContainerSizeFactor = Tween<double>(
          begin: 1,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0,
              0.300,
              curve: Curves.elasticIn,
            ),
          ),
        ),
        logoOpacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.300,
              0.600,
              curve: Curves.ease,
            ),
          ),
        ),
        logoRotation = Tween<double>(
          begin: 0.5,
          end: 0.01,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.650,
              1,
              curve: Curves.easeIn,
            ),
          ),
        ),
        logoPosition = Tween<Alignment>(
          begin: Alignment.center,
          end: const Alignment(0, -2.2),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.850,
              1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        builder: _buildAnimation,
        animation: controller,
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Stack(
      children: [
        Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * backgroundContainerSizeFactor.value,
                height: constraints.maxHeight * backgroundContainerSizeFactor.value,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(40 * backgroundContainerSizeFactor.value),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: logoPosition.value,
          child: Transform.rotate(
            angle: pi / logoRotation.value,
            child: Opacity(
              opacity: logoOpacity.value,
              child: Image.asset(AppAssets.appLogo),
            ),
          ),
        ),
      ],
    );
  }
}

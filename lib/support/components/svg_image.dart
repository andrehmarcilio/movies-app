import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final String svgPath;
  final double? height;
  final ColorFilter? colorFilter;

  const SvgImage({
    required this.svgPath,
    this.height,
    this.colorFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      height: height,
      colorFilter: colorFilter,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageWidget extends StatelessWidget {
  final String iconName;
  final double? height;
  final double? width;
  final Color  color;

  const SvgImageWidget({
    super.key,
    required this.iconName, 
    required this.color, 
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      semanticsLabel: 'icon',
      height: height ?? 16,
      width: width ?? 16, 
      // colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
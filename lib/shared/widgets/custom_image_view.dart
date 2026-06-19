/* import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import 'package:myschoolio/core/constants/image.dart';

enum ImageType { file, network, asset } /* svg */

extension ImageTypeExtension on String {
  ImageType get imageType {
    // if (endsWith('.svg')) return ImageType.svg;
    if (startsWith('http')) return ImageType.network;
    if (startsWith('/')) return ImageType.file;
    return ImageType.asset;
  }
}

class CustomImageView extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;

  static const String fallbackImage = Images.imageNotFound;

  const CustomImageView({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.margin,
    this.radius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = _buildImageView();

    if (radius != null) {
      imageWidget = ClipRRect(borderRadius: radius!, child: imageWidget);
    }

    if (border != null) {
      imageWidget = Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: imageWidget,
      );
    }

    if (onTap != null) {
      imageWidget = InkWell(onTap: onTap, child: imageWidget);
    }

    if (margin != null) {
      imageWidget = Padding(padding: margin!, child: imageWidget);
    }

    if (alignment != null) {
      imageWidget = Align(alignment: alignment!, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _buildImageView() {
    switch (imagePath.imageType) {
      /* case ImageType.svg:
        return SvgPicture.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
          placeholderBuilder: (_) => _fallbackImage(),
        ); */
      case ImageType.file:
        return Image.file(
          File(imagePath),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
          errorBuilder: (_, __, ___) => _fallbackImage(),
        );
      case ImageType.network:
        return Image.network(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
          errorBuilder: (_, __, ___) => _fallbackImage(),
        );
      case ImageType.asset:
        return Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          color: color,
          errorBuilder: (_, __, ___) => _fallbackImage(),
        );
    }
  }

  Widget _fallbackImage() {
    return Image.asset(
      fallbackImage,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }
}
 */
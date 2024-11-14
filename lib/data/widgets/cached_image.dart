import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
  });
  
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: imageUrl,
      placeholder: (context, url) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        );
      },
    );
  }
}

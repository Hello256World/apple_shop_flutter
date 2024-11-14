import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/product_banner.dart';
import 'package:apple_shop_flutter/data/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider(
    this._banners, {
    super.key,
  });
  final List<ProductBanner> _banners;

  @override
  Widget build(BuildContext context) {
    var pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.9,
    );
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: pageController,
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedImage(
                    imageUrl: _banners[index].thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: pageController,
            count: _banners.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: CustomColor.blueColor,
              dotColor: Colors.white,
              expansionFactor: 4,
              dotWidth: 10,
              dotHeight: 10,
            ),
          ),
        ),
      ],
    );
  }
}

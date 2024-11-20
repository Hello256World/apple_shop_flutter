import 'package:apple_shop_flutter/bloc/shopping_card/shopping_card_bloc.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/widgets/cached_image.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:apple_shop_flutter/ui/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
    this._product, {
    super.key,
  });

  final Product _product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<ShoppingCardBloc>.value(
                value: locator.get<ShoppingCardBloc>(),
                child: ProductScreen(product: _product),
              );
            },
          ),
        );
      },
      child: Container(
        width: 160,
        height: 216,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 160,
              height: 124,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Positioned(
                    width: 80,
                    height: 104,
                    top: 10,
                    child: CachedImage(
                      imageUrl: _product.thumbnail,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.asset('assets/images/Vector.png'),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      width: 25,
                      height: 15,
                      decoration: BoxDecoration(
                        color: CustomColor.redColor,
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '%${((_product.discountPrice / _product.price) * 100).round()}',
                        style: const TextStyle(
                          fontFamily: 'SB',
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10),
                child: Text(
                  _product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'SM', fontSize: 14),
                ),
              ),
            ),
            Container(
              width: 160,
              height: 53,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: CustomColor.blueColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.blueColor,
                    blurRadius: 20,
                    spreadRadius: -10,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Text(
                    'تومان',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _product.price.toString(),
                        style: const TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.white,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        (_product.price - _product.discountPrice).toString(),
                        style: const TextStyle(
                          fontFamily: 'SM',
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Image(
                    width: 20,
                    height: 20,
                    image: AssetImage('assets/images/right_arrow.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:apple_shop_flutter/bloc/demo/demo_bloc.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/widgets/cached_image.dart';
import 'package:apple_shop_flutter/ui/demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
    this._category, {
    super.key,
  });
  final Category _category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => DemoBloc(),
              child: DemoScreen(
                _category,
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: _category.color.toHexColor(),
                  shadows: [
                    BoxShadow(
                      color: _category.color.toHexColor(),
                      spreadRadius: -10,
                      blurRadius: 25,
                      offset: const Offset(0.0, 10),
                    )
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                alignment: Alignment.center,
              ),
              CachedImage(
                imageUrl: _category.icon,
                width: 26,
                height: 26,
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _category.title,
            style: const TextStyle(fontFamily: 'SB', fontSize: 12),
          ),
        ],
      ),
    );
  }
}

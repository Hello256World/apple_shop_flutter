import 'package:apple_shop_flutter/bloc/home/home_bloc.dart';
import 'package:apple_shop_flutter/bloc/home/home_event.dart';
import 'package:apple_shop_flutter/bloc/home/home_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/models/product_banner.dart';
import 'package:apple_shop_flutter/data/widgets/banner_slider.dart';
import 'package:apple_shop_flutter/data/widgets/category_item.dart';
import 'package:apple_shop_flutter/data/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeResponseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SearchBar(),
                if (state is HomeLoadingState) ...[
                  const SliverFillRemaining(
                    child: UnconstrainedBox(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
                if (state is HomeResponseState) ...[
                  state.banners.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return BannerSliderSection(r);
                    },
                  ),
                ],
                if (state is HomeResponseState) ...[
                  state.categories.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return CategorySection(r);
                    },
                  )
                ],
                if (state is HomeResponseState) ...[
                  state.bestSellerProducts.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return MostSellsSection(r);
                    },
                  )
                ],
                if (state is HomeResponseState) ...[
                  state.hottestProducts.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return MostViewSection(r);
                    },
                  )
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class MostViewSection extends StatelessWidget {
  const MostViewSection(
    this._products, {
    super.key,
  });

  final List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 44.0, right: 44.0, bottom: 20.0),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/images/left_arrow.png'),
                ),
                SizedBox(width: 10.0),
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    color: CustomColor.blueColor,
                    fontSize: 12,
                    fontFamily: 'SB',
                  ),
                ),
                Spacer(),
                Text(
                  'پربازدید ترین ها',
                  style: TextStyle(
                    fontFamily: 'SB',
                    color: CustomColor.greyColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 248,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return index == 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 44, left: 20),
                        child: UnconstrainedBox(
                          alignment: Alignment.topCenter,
                          child: ProductItem(_products[index]),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: UnconstrainedBox(
                          alignment: Alignment.topCenter,
                          child: ProductItem(_products[index]),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MostSellsSection extends StatelessWidget {
  const MostSellsSection(
    this._products, {
    super.key,
  });

  final List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(44.0, 32.0, 44.0, 20.0),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/images/left_arrow.png'),
                ),
                SizedBox(width: 10.0),
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    color: CustomColor.blueColor,
                    fontSize: 12,
                    fontFamily: 'SB',
                  ),
                ),
                Spacer(),
                Text(
                  'پرفروش ترین ها',
                  style: TextStyle(
                    fontFamily: 'SB',
                    color: CustomColor.greyColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 248,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return index == 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 44, left: 20),
                        child: UnconstrainedBox(
                          alignment: Alignment.topCenter,
                          child: ProductItem(_products[index]),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: UnconstrainedBox(
                          alignment: Alignment.topCenter,
                          child: ProductItem(_products[index]),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<Category> _categories;
  const CategorySection(
    this._categories, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 44,
              top: 32,
              bottom: 20,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'دسته بندی',
                style: TextStyle(
                    color: CustomColor.greyColor,
                    fontSize: 12,
                    fontFamily: 'SB'),
              ),
            ),
          ),
          SizedBox(
            height: 85,
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 44, left: 20),
                    child: CategoryItem(_categories[index]),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CategoryItem(_categories[index]),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BannerSliderSection extends StatelessWidget {
  const BannerSliderSection(
    this._banners, {
    super.key,
  });
  final List<ProductBanner> _banners;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(_banners),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 46,
        margin: const EdgeInsets.fromLTRB(44, 20, 44, 32),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Image(
              image: AssetImage('assets/images/blue_apple.png'),
            ),
            const Expanded(
                child: TextField(
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'جستجوی محصولات',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SB',
                  color: CustomColor.greyColor,
                ),
                hintTextDirection: TextDirection.rtl,
              ),
            )),
            const SizedBox(width: 10),
            Image.asset('assets/images/search_icon.png'),
          ],
        ),
      ),
    );
  }
}

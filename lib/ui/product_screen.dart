import 'dart:ui';
import 'package:apple_shop_flutter/bloc/product/product_bloc.dart';
import 'package:apple_shop_flutter/bloc/product/product_event.dart';
import 'package:apple_shop_flutter/bloc/product/product_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/product.dart';
import 'package:apple_shop_flutter/data/models/product_variant.dart';
import 'package:apple_shop_flutter/data/models/variant_type.dart';
import 'package:apple_shop_flutter/data/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedColorIndex = 2;
  int selectedPhoneImageIndex = 0;

  @override
  void initState() {
    super.initState();

    // '5vvww65pv6nviw6' at0y1gm0t65j62j  at0y1gm0t65j62j
    context.read<ProductBloc>().add(
        ProductInitializeEvent(widget.product.id, widget.product.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return CustomScrollView(
                slivers: [
                  if (state is ProductResponseState) ...{
                    SliverToBoxAdapter(
                      child: Container(
                        height: 46,
                        margin: const EdgeInsets.fromLTRB(44, 20, 44, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/blue_apple.png'),
                            state.productCategory.fold(
                              (l) {
                                return const Text(
                                  'دسته بندی',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    color: CustomColor.blueColor,
                                    fontSize: 16,
                                  ),
                                );
                              },
                              (r) {
                                return Text(
                                  r.title,
                                  style: const TextStyle(
                                    fontFamily: 'SB',
                                    color: CustomColor.blueColor,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                            Image.asset('assets/images/black_right_arrow.png'),
                          ],
                        ),
                      ),
                    ),
                  },
                  SliverToBoxAdapter(
                    child: Text(
                      widget.product.name,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (state is ProductResponseState) ...{
                    state.productImages.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (r) {
                        return SliverToBoxAdapter(
                          child: Container(
                            height: 284,
                            margin: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 44,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: -20,
                                    offset: const Offset(0.0, 20.0),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 166,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Image.asset(
                                          'assets/images/star_icon.png',
                                        ),
                                      ),
                                      const Positioned(
                                        top: 12,
                                        left: 42,
                                        child: Text(
                                          '4.6',
                                          style: TextStyle(
                                            fontFamily: 'SM',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 18,
                                        width: 150,
                                        height: 150,
                                        child: CachedImage(
                                          imageUrl: (r.isNotEmpty)
                                              ? r[selectedPhoneImageIndex]
                                                  .imageUrl
                                              : widget.product.thumbnail,
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Image.asset(
                                          'assets/images/deactive_heart.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (r.isNotEmpty) ...{
                                  Container(
                                    height: 118,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 45,
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 18,
                                      bottom: 30,
                                    ),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: r.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedPhoneImageIndex = index;
                                            });
                                          },
                                          child: Container(
                                              width: 70,
                                              height: 70,
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 1,
                                                  color: CustomColor.greyColor,
                                                ),
                                              ),
                                              child: CachedImage(
                                                  imageUrl: r[index].imageUrl)),
                                        );
                                      },
                                    ),
                                  ),
                                }
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  },
                  if (state is ProductResponseState) ...{
                    state.productVariants.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (r) {
                        return VariantsGenerator(r);
                      },
                    )
                  },
                  if (state is ProductResponseState) ...{
                    ProductDescriptionSection(
                        widget.product.description, state),
                  },
                  SliverToBoxAdapter(
                    child: Container(
                      height: 58,
                      margin: const EdgeInsets.fromLTRB(22, 38, 22, 32),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 10,
                            child: Container(
                              height: 47,
                              width: 140,
                              decoration: BoxDecoration(
                                color: CustomColor.greenColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: SizedBox(
                                  width: 160,
                                  height: 53,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '17,800,000',
                                              style: TextStyle(
                                                fontFamily: 'SM',
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: Colors.white,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '16,989,000',
                                              style: TextStyle(
                                                fontFamily: 'SB',
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 25,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: CustomColor.redColor,
                                            borderRadius:
                                                BorderRadius.circular(7.5),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            '%3',
                                            style: TextStyle(
                                              fontFamily: 'SB',
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 10,
                            child: Container(
                              height: 47,
                              width: 140,
                              decoration: BoxDecoration(
                                color: CustomColor.blueColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: const SizedBox(
                                  width: 160,
                                  height: 53,
                                  child: Center(
                                      child: Text(
                                    'افزودن به سبد خرید',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductDescriptionSection extends StatefulWidget {
  const ProductDescriptionSection(
    this.productDescription,
    this.state, {
    super.key,
  });

  final String productDescription;
  final ProductResponseState state;

  @override
  State<ProductDescriptionSection> createState() =>
      _ProductDescriptionSectionState();
}

class _ProductDescriptionSectionState extends State<ProductDescriptionSection> {
  bool _descriptionVisible = false;
  bool _techDescVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _techDescVisible = !_techDescVisible;
                });
              },
              child: Container(
                height: 46,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1,
                    color: CustomColor.greyColor,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/left_arrow.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SB',
                        color: CustomColor.blueColor,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'مشخصات فنی:',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _techDescVisible,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _techDescVisible ? 1 : 0,
                curve: Curves.bounceIn,
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        color: CustomColor.greyColor,
                      ),
                    ),
                    child: widget.state.productProperties.fold(
                      (l) {
                        return Text(l);
                      },
                      (r) {
                        if (r.isNotEmpty) {
                          return Column(
                            children: [
                              ...List.generate(r.length, (index) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${r[index].title}:${r[index].value}',
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      fontFamily: 'SM',
                                      fontSize: 14,
                                      height: 1.8,
                                    ),
                                  ),
                                );
                              })
                            ],
                          );
                        }
                        return const Text('مشخصاتی ندارد');
                      },
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _descriptionVisible = !_descriptionVisible;
                });
              },
              child: Container(
                height: 46,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1,
                    color: CustomColor.greyColor,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/left_arrow.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SB',
                        color: CustomColor.blueColor,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'توضیحات محصول:',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'SM',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _descriptionVisible,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _descriptionVisible ? 1 : 0,
                curve: Curves.bounceIn,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1,
                      color: CustomColor.greyColor,
                    ),
                  ),
                  child: Text(
                    widget.productDescription,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 46,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: CustomColor.greyColor,
                ),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/left_arrow.png'),
                  const SizedBox(width: 10),
                  const Text(
                    'مشاهده',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SB',
                      color: CustomColor.blueColor,
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 45,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 60,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: CustomColor.greyColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '+10',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'SB',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'نظر کاربران:',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 12,
                      color: Colors.black,
                    ),
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

class VariantsGenerator extends StatelessWidget {
  const VariantsGenerator(this.productVariantsList, {super.key});

  final List<ProductVariant> productVariantsList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantsList) ...{
            if (productVariant.variantType.variantType ==
                    VariantTypeEnum.color &&
                productVariant.variants.isNotEmpty) ...{
              ColorVariantSection(productVariants: productVariant),
            },
            if (productVariant.variantType.variantType ==
                    VariantTypeEnum.storage &&
                productVariant.variants.isNotEmpty) ...{
              StorageVariantSection(
                productVariant: productVariant,
              ),
            },
            if (productVariant.variantType.variantType ==
                    VariantTypeEnum.voltage &&
                productVariant.variants.isNotEmpty) ...{
              StorageVariantSection(productVariant: productVariant)
            }
          }
        ],
      ),
    );
  }
}

class StorageVariantSection extends StatefulWidget {
  const StorageVariantSection({
    super.key,
    required this.productVariant,
  });

  final ProductVariant productVariant;

  @override
  State<StorageVariantSection> createState() => _StorageVariantSectionState();
}

class _StorageVariantSectionState extends State<StorageVariantSection> {
  int selectedStorage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.productVariant.variantType.title,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...List.generate(
                widget.productVariant.variants.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStorage = index;
                      });
                    },
                    child: Container(
                      width: 74.0,
                      height: 26.0,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: selectedStorage != index
                            ? Border.all(
                                color: CustomColor.greyColor, width: 0.5)
                            : Border.all(
                                color: CustomColor.blueColor, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.productVariant.variants[index].value,
                        style: const TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ).reversed,
            ],
          ),
        ],
      ),
    );
  }
}

class ColorVariantSection extends StatefulWidget {
  const ColorVariantSection({super.key, required this.productVariants});
  final ProductVariant productVariants;

  @override
  State<ColorVariantSection> createState() => _ColorVariantSectionState();
}

class _ColorVariantSectionState extends State<ColorVariantSection> {
  int selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedColorIndex = widget.productVariants.variants.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 44.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.productVariants.variantType.title,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...List.generate(
                widget.productVariants.variants.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.only(right: 20),
                      width: selectedColorIndex == index ? 77 : 26,
                      height: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: widget.productVariants.variants[index].value
                            .toHexColor(),
                        border: Border.all(
                          color: CustomColor.greyColor,
                          width: 0.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: AnimatedOpacity(
                        opacity: selectedColorIndex == index ? 1.0 : 0.0,
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 1500),
                        child: Text(
                          widget.productVariants.variants[index].name,
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                            color: widget.productVariants.variants[index].value
                                        .toHexColor() ==
                                    Colors.white
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

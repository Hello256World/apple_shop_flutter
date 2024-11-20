import 'package:apple_shop_flutter/bloc/shopping_card/shopping_card_bloc.dart';
import 'package:apple_shop_flutter/bloc/shopping_card/shopping_card_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/shopping_card.dart';
import 'package:apple_shop_flutter/data/widgets/cached_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingCardScreen extends StatefulWidget {
  const ShoppingCardScreen({super.key});

  @override
  State<ShoppingCardScreen> createState() => _ShoppingCardScreenState();
}

class _ShoppingCardScreenState extends State<ShoppingCardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: SafeArea(child: BlocBuilder<ShoppingCardBloc, ShoppingCardState>(
        builder: (context, state) {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 46,
                          margin: const EdgeInsets.fromLTRB(44, 20, 44, 32),
                          padding: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        const Positioned(
                          top: 30,
                          left: 59,
                          child: Image(
                            image: AssetImage('assets/images/blue_apple.png'),
                          ),
                        ),
                        const Positioned(
                          top: 31,
                          child: Text(
                            'سبد خرید',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CustomColor.blueColor,
                              fontFamily: 'SB',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is ShoppingCardDataState) ...{
                    state.cards.fold(
                      (l) {
                        return const SliverToBoxAdapter();
                      },
                      (r) {
                        return SliverPadding(
                          padding: const EdgeInsets.only(bottom: 78),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ShoppingCardItem(r[index]);
                              },
                              childCount: r.length,
                            ),
                          ),
                        );
                      },
                    )
                  }
                ],
              ),
              if (state is ShoppingCardDataState) ...{
                state.cards.fold(
                  (l) {
                    return Positioned(
                      left: 44,
                      right: 44,
                      bottom: 20,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size.fromHeight(53),
                        ),
                        child: const Text(
                          'ادامه فرآیند خرید',
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  (r) {
                    var totalPrice = r.fold(
                      0,
                      (initPrice, shoppingCard) =>
                          initPrice +
                          (shoppingCard.price - shoppingCard.discountPrice),
                    );
                    return Positioned(
                      left: 44,
                      right: 44,
                      bottom: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse('https://okala.com'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size.fromHeight(53),
                        ),
                        child: Text(
                          totalPrice == 0
                              ? 'سبد خرید شما خالی است'
                              : totalPrice.toString(),
                          style: const TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                )
              }
            ],
          );
        },
      )),
    );
  }
}

class ShoppingCardItem extends StatelessWidget {
  const ShoppingCardItem(
    this.card, {
    super.key,
  });

  final ShoppingCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 239,
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: CustomColor.greyColor,
              offset: Offset(0.0, 10.0),
              blurRadius: 30,
              spreadRadius: -25,
            )
          ]),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          card.name,
                          style:
                              const TextStyle(fontFamily: 'SB', fontSize: 16),
                        ),
                        const Text(
                          'گارانتی 18 ماهه مدیاتک',
                          style: TextStyle(fontFamily: 'SM', fontSize: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 25,
                              height: 15,
                              decoration: BoxDecoration(
                                color: CustomColor.redColor,
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '%${((card.discountPrice / card.price) * 100).round()}',
                                style: const TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'تومان',
                                style: TextStyle(
                                  fontFamily: 'SM',
                                  fontSize: 10,
                                  color: CustomColor.greyColor,
                                ),
                              ),
                            ),
                            Text(
                              card.discountPrice.toString(),
                              style: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                                color: CustomColor.greyColor,
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          alignment: WrapAlignment.end,
                          children: [
                            const CardOption(
                              title: '256 گیگابایت',
                            ),
                            const CardOption(
                              title: 'آبی',
                              color: '0330fc',
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffE5E5E5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'حذف',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'SM',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Image.asset('assets/images/trash_icon.png'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 18),
                  child: CachedImage(
                    imageUrl: card.thumbnail,
                    width: 80,
                    height: 104,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: DottedLine(
              dashColor: CustomColor.whiteColor,
              dashGapColor: Colors.transparent,
              lineThickness: 2,
              dashLength: 10,
              dashGapLength: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  (card.price - card.discountPrice).toString(),
                  style: const TextStyle(
                    fontFamily: 'SM',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  const CardOption({
    super.key,
    required this.title,
    this.color,
  });
  final String title;
  final String? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffE5E5E5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'SM',
              fontWeight: FontWeight.w500,
            ),
          ),
          if (color != null) ...{
            const SizedBox(width: 5),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color!.toHexColor(),
                shape: BoxShape.circle,
              ),
            ),
          }
        ],
      ),
    );
  }
}

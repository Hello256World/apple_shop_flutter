import 'package:apple_shop_flutter/bloc/demo/demo_bloc.dart';
import 'package:apple_shop_flutter/bloc/demo/demo_event.dart';
import 'package:apple_shop_flutter/bloc/demo/demo_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen(this.category, {super.key});

  final Category category;

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  void initState() {
    super.initState();

    context.read<DemoBloc>().add(ProductResponseEvent(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: SafeArea(
        child: BlocBuilder<DemoBloc, DemoState>(
          builder: (context, state) {
            if (state is LoadingProductState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return CustomScrollView(
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
                        Positioned(
                          top: 31,
                          child: Text(
                            widget.category.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: CustomColor.blueColor,
                              fontFamily: 'SB',
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state is ProductResponseState) ...{
                    state.products.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (r) {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 44),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: r.length,
                              (context, index) {
                                return ProductItem(r[index]);
                              },
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1 / 1.6,
                            ),
                          ),
                        );
                      },
                    )
                  }
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

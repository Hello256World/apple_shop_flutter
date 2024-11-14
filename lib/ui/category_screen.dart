import 'package:apple_shop_flutter/bloc/category/category_bloc.dart';
import 'package:apple_shop_flutter/bloc/category/category_event.dart';
import 'package:apple_shop_flutter/bloc/category/category_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/data/models/category.dart';
import 'package:apple_shop_flutter/data/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: SafeArea(
          child: CustomScrollView(
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
                    'دسته بندی',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColor.blueColor,
                      fontFamily: 'SB',
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
             if (state is CategoryLoadingState) {
              return const SliverFillRemaining(
                child: UnconstrainedBox(child: CircularProgressIndicator()),
              );
            } else if (state is FetchCategoryState) {
              return state.categoryList.fold(
                (l) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(l),
                    ),
                  );
                },
                (r) {
                  return ImagesGrid(categoryList: r);
                },
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('Error'),
                ),
              );
            }
          })
        ],
      )),
    );
  }
}

class ImagesGrid extends StatelessWidget {
  const ImagesGrid({super.key, required this.categoryList});
  final List<Category>? categoryList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: categoryList?.length ?? 0,
          (context, index) {
            return CachedImage(
                imageUrl: categoryList?[index].thumbnail ?? 'image');
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}

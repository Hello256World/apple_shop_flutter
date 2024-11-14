import 'package:apple_shop_flutter/data/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
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
                    'حساب کاربری',
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
            const Text(
              'میلاد رفاه',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'SB',
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '091212121212',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: CustomColor.greyColor,
              ),
            ),
            const SizedBox(height: 20),
            const Wrap(
              runSpacing: 20,
              spacing: 38,
              alignment: WrapAlignment.end,
              children: [
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
                // CategoryItem(),
              ],
            ),
            const Spacer(),
            const Text(
              'دیجی کالا',
              style: TextStyle(
                fontFamily: 'SM',
                color: CustomColor.greyColor,
                fontSize: 10,
              ),
            ),
            const Text(
              'V-1.00.0',
              style: TextStyle(
                fontFamily: 'SM',
                color: CustomColor.greyColor,
                fontSize: 10,
              ),
            ),
            const Text(
              'github.com/Hello256World',
              style: TextStyle(
                fontFamily: 'GM',
                color: CustomColor.greyColor,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

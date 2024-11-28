import 'package:apple_shop_flutter/bloc/autherntication/auth_bloc.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_event.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:apple_shop_flutter/ui/login_screen.dart';
import 'package:apple_shop_flutter/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = AuthBloc(locator.get());

        bloc.stream.forEach((state) {
          if (state is AuthResponseState) {
            state.response.fold(
              (l) {
                var snackBar = SnackBar(
                  content: Text(
                    l,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(fontFamily: 'dana', fontSize: 14),
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              (r) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
            );
          }
        });
        return bloc;
      },
      child: RegisterScreenContent(),
    );
  }
}

class RegisterScreenContent extends StatelessWidget {
  RegisterScreenContent({
    super.key,
  });

  final TextEditingController _usernameController =
      TextEditingController(text: 'Milad3');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  final TextEditingController _passwordConfirmController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
              width: double.infinity,
            ),
            Image.asset(
              'assets/images/register.jpg',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'نام کاربری :',
                    style: TextStyle(
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  TextField(
                    controller: _usernameController,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'رمز عبور :',
                    style: TextStyle(
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'تکرار رمز عبور : ',
                    style: TextStyle(
                      fontFamily: 'dana',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  TextField(
                    controller: _passwordConfirmController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthResponseState) {
                        return state.response.fold(
                          (l) {
                            return Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                        RegisterRequestEvent(
                                          _usernameController.text,
                                          _passwordController.text,
                                          _passwordConfirmController.text,
                                        ),
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColor.blueColor,
                                  foregroundColor: Colors.white,
                                  fixedSize: const Size(150, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'ثبت نام',
                                  style:
                                      TextStyle(fontFamily: 'SB', fontSize: 15),
                                ),
                              ),
                            );
                          },
                          (r) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(r),
                            );
                          },
                        );
                      }

                      switch (state) {
                        case AuthInitState():
                          return Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      RegisterRequestEvent(
                                        _usernameController.text,
                                        _passwordController.text,
                                        _passwordConfirmController.text,
                                      ),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColor.blueColor,
                                foregroundColor: Colors.white,
                                fixedSize: const Size(150, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'ثبت نام',
                                style:
                                    TextStyle(fontFamily: 'SB', fontSize: 15),
                              ),
                            ),
                          );
                        case AuthLoadingState():
                          return const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: CustomColor.blueColor,
                            ),
                          );
                        default:
                          return const Text('خطایی رخ داده است');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text('اگر حساب کاربری دارید وارد شوید')),
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

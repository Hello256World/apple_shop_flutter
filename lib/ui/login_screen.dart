import 'package:apple_shop_flutter/bloc/autherntication/auth_bloc.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_event.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:apple_shop_flutter/main.dart';
import 'package:apple_shop_flutter/ui/main_screen.dart';
import 'package:apple_shop_flutter/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController =
      TextEditingController(text: 'Milad');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(locator.get()),
      child: LoginScreenContent(
          usernameController: _usernameController,
          passwordController: _passwordController),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _usernameController = usernameController,
        _passwordController = passwordController;

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'assets/images/login_photo.jpg',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthResponseState) {
                          state.response.fold(
                            (l) {
                              var snackBar = SnackBar(
                                content: Text(
                                  l,
                                  style: const TextStyle(
                                      fontFamily: 'dana', fontSize: 14.0),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 3),
                                backgroundColor: Colors.black,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              _passwordController.text = '';
                              _usernameController.text = '';
                            },
                            (r) {
                              navigateGlobalKey.currentState?.pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthResponseState) {
                          return state.response.fold(
                            (l) {
                              return Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                          LoginRequestEvent(
                                            _usernameController.text,
                                            _passwordController.text,
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
                                    'ورود به حساب',
                                    style: TextStyle(
                                        fontFamily: 'SB', fontSize: 15),
                                  ),
                                ),
                              );
                            },
                            (r) {
                              return Text(r);
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
                                        LoginRequestEvent(
                                          _usernameController.text,
                                          _passwordController.text,
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
                                  'ورود به حساب',
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
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                              'اگر حساب کاربری ندارید ثبت نام کنید')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

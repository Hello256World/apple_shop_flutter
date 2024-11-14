import 'package:apple_shop_flutter/bloc/autherntication/auth_bloc.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_event.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_state.dart';
import 'package:apple_shop_flutter/data/constants.dart';
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
    return Scaffold(
      backgroundColor: CustomColor.blueColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/icon_application.png'),
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'اپل شاپ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'SB',
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'نام کاربری',
                            labelStyle: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: CustomColor.blueColor, width: 3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'رمز عبور',
                            labelStyle: const TextStyle(
                              fontFamily: 'SM',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: CustomColor.blueColor, width: 3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthResponseState) {
                              return state.response.fold(
                                (l) {
                                  return Text(l);
                                },
                                (r) {
                                  return Text(r);
                                },
                              );
                            }

                            switch (state) {
                              case AuthInitState():
                                return ElevatedButton(
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
                                );
                              case AuthLoadingState():
                                return const CircularProgressIndicator(
                                  color: CustomColor.blueColor,
                                );
                              default:
                                return const Text('خطایی رخ داده است');
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

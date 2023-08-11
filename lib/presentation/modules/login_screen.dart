import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_store/business_logic/login_cubit/auth_cubit.dart';
import 'package:mini_store/presentation/layouts/home_layout.dart';
import 'package:mini_store/presentation/modules/register_screen.dart';
import 'package:mini_store/shared/shared_functions/navigation.dart';

import '../../data/repositories/authentication_repository.dart';
import '../../shared/shared_functions/snack_bar.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, LoginState>(
        listener: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          if (state is LoginErrorState) {
            customSnackBar(
                context: context,
                message: state.message,
                durationInSec: 7,
                label: "error");
          }
          if (state is LoggedInState) {
            navigateToWithReplace(context, const HomeLayout());
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  AuthCubit.get(context).changePasswordVisibility();
                                },
                                icon: AuthCubit.get(context).isHiddenPassword? const Icon(Icons.visibility_off_outlined):const Icon(Icons.visibility_outlined),
                              )),
                          obscureText: AuthCubit.get(context).isHiddenPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              AuthCubit.get(context).login(
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          },
                          child: ConditionalBuilder(
                              condition: AuthCubit.get(context).loginLoading,
                              builder: (context) => const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                              fallback: (context) => const Text('Login')),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Text("Don\'t have an account? "),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text("Sign up"))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            // Implement forgot password logic
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}

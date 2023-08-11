import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_store/business_logic/login_cubit/auth_cubit.dart';

import '../../shared/shared_functions/navigation.dart';
import '../../shared/shared_functions/snack_bar.dart';
import '../layouts/home_layout.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(context) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).register(_nameController.text, _emailController.text, _phoneController.text, _passwordController.text);
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: BlocConsumer<AuthCubit, LoginState>(
        listener: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          if (state is RegisterErrorState) {
            customSnackBar(
                context: context,
                message: state.message,
                durationInSec: 7,
                label: "error");
          }
          if (state is RegisteredState) {
            navigateToWithReplace(context, const HomeLayout());
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add additional email validation logic here
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // You can add additional phone number validation logic here
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // You can add additional password validation logic here
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: ()=>_submitForm(context),
                        child: ConditionalBuilder(
                            condition: AuthCubit.get(context).registerLoading,
                            builder: (context) => const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                            fallback: (context) => const Text('Register')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

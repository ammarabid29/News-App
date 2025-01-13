import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/custom_button.dart';
import 'package:news_app/core/utils/custom_form_field.dart';
import 'package:news_app/features/auth/presentation/view_model/login/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: height * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/splash_pic.jpg",
                      fit: BoxFit.cover,
                      height: height * .3,
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: "Email",
                      icon: Icon(Icons.email_outlined),
                      validator: (value) {
                        return _loginViewModel.validateEmail(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      obscure: true,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      hint: "Password",
                      icon: Icon(Icons.password_outlined),
                      validator: (value) {
                        return _loginViewModel.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      isLoading: isLoading,
                      title: "Login",
                      onTap: () {
                        return _loginViewModel.handleLogin(
                          context: context,
                          formKey: _formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          setLoading: (loading) {
                            setState(() {
                              isLoading = loading;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            return _loginViewModel
                                .navigateToSignupScreen(context);
                          },
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        "Login",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}

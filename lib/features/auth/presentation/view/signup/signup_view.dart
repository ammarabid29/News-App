import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/custom_button.dart';
import 'package:news_app/core/utils/custom_form_field.dart';
import 'package:news_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:news_app/features/auth/domain/usecases/auth_use_cases.dart';
import 'package:news_app/features/auth/presentation/view_model/signup/signup_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  late final SignupViewModel _signupViewModel;
  late final SignupUserUseCase _signupUserUseCase;
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();

    _authRepository = AuthRepositoryImpl();
    _signupUserUseCase = SignupUserUseCase(_authRepository);
    _signupViewModel = SignupViewModel(_signupUserUseCase);
  }

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
                    CustomFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hint: "Email",
                      icon: Icon(Icons.email_outlined),
                      validator: (value) {
                        return _signupViewModel.validateEmail(value);
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
                        return _signupViewModel.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      isLoading: isLoading,
                      title: "Signup",
                      onTap: () {
                        return _signupViewModel.handleSignup(
                          context: context,
                          formKey: _formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          setLoading: (bool loading) {
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
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            return _signupViewModel
                                .navigateToLoginScreen(context);
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Signup",
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}

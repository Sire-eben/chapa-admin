import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/authentication/services/auth_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/routing/route_names.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, __) {
      return Scaffold(
        body: authService.isLoading
            ? const PageLoaderWithPadding()
            : Center(
                child: IntrinsicHeight(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .4,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: Shadows.universal,
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(22.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Admin Login",
                            style: AppStyles.urbanist24Xbd,
                          ),
                          30.height,
                          CustomTextField(
                            controller: _emailController,
                            labelText: "Enter Email",
                            hintText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter an email' : null,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: "Enter Password",
                            hintText: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a password' : null,
                            obscureText: isPasswordVisible,
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              }),
                              icon: isPasswordVisible
                                  ? Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 20,
                                      color: AppColors.secondaryIconColor,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: AppColors.secondaryIconColor,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          PrimaryButton(
                            isLoading: authService.isLoading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await authService.signInWithEmail(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  bool isAdmin = await authService.checkAdmin();
                                  if (isAdmin) {
                                    locator<NavigationService>()
                                        .navigateTo(dashboard);
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => HomeScreen()),
                                    // );
                                  } else {
                                    await authService.signOut();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Only admins can log in')),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            },
                            label: "Login",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}

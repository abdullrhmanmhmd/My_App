import 'package:docdoc/core/constants/my_colors.dart';
import 'package:docdoc/core/network/api_error.dart';
import 'package:docdoc/logic/auth/auth_repo.dart';
import 'package:docdoc/logic/models/user_model.dart';
import 'package:docdoc/ui/signin/widgets/signin_terms_and_conditions_text.dart';
import 'package:docdoc/ui/widgets/app_text_button.dart';
import 'package:docdoc/ui/widgets/app_text_form_field.dart';
import 'package:docdoc/ui/widgets/bottom_navigation.dart';
import 'package:docdoc/ui/widgets/custom_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:docdoc/ui/signin/widgets/all_ready_have_an_acount.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  UserModel userModel = UserModel();
  bool isObscure = true;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  AuthRepo authRepo = AuthRepo();

  Future<void> signup() async {
    setState(() => isLoading = true);
    try {
      final user = await authRepo.signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
        phoneController.text.trim(),


      );
      if (user != null && user.token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationWidget(userModel: user,)),
        );
      }
    } catch (e) {
      String error = "Signup not working";
      if (e is ApiError) {
        error = e.massage;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(error));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.myBlue,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Sign up now and start exploring all that our app has to offer. We're excited to welcome\nyou to our community!",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: MyColors.myGrey,
                  ),
                ),
                SizedBox(height: 36.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        hintText: 'Name',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 18.h),
                      AppTextFormField(
                        hintText: 'Email',
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 18.h),
                      AppTextFormField(
                        controller: passwordController,
                        hintText: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                        },
                        isPassword: isObscure,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: MyColors.myGrey,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      AppTextFormField(
                        isPassword: isObscure,
                        hintText: 'Confirm Password',
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Confirm your password';
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: MyColors.myGrey,
                            size: 20.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 18.h),
                      AppTextFormField(
                        hintText: 'Phone',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        controller: phoneController,
                      ),

                      SizedBox(height: 30.h),

                      isLoading
                          ? CircularProgressIndicator(
                              color: MyColors.myBlue,
                              strokeWidth: 2,
                              backgroundColor: MyColors.myWhite,
                            )
                          : AppTextButton(
                              buttonText: 'Create Account',

                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: MyColors.myWhite,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  signup();
                                }
                              },
                            ),
                      SizedBox(height: 24.h),
                      SigninTermsAndConditionsText(),

                      SizedBox(height: 40.h),
                      AllReadyHaveAnAcount(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

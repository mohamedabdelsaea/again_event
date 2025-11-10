import 'dart:developer';
import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/core/widgets/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../core/utils/fire_base/auth_firebase.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPassword = false;
  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: Text(
          'Register',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: AppColor.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                height: size.height * 0.2,
                width: size.width * 0.2,
              ),
              // Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter name';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: ImageIcon(
                        AssetImage('assets/images/name_icon.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter Phone';
                    } else if (value.trim().length < 11) {
                      return 'Please enter full phone number';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Phone number must contain digits only';
                    }
                    return null;
                  },
                  controller: _phoneController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Phone',
                    // hintStyle: TextStyle(
                    //   fontSize: 18,
                    //   fontWeight: FontWeight.w500,
                    //   color: AppColor.primary
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: ImageIcon(
                        AssetImage('assets/icons/free_phone.png'),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter Email';
                    }
                    if (!Validation.validateEmail(value)) {
                      return '^[a-zA-Z0-9_%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'E mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: ImageIcon(
                        AssetImage('assets/images/email_icon.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter password';
                    }
                    if (!Validation.validatePassword(value)) {
                      return '^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}';
                    }
                    return null;
                  },
                  obscureText: _isPassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: ImageIcon(
                        AssetImage('assets/images/password_icon.png'),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPassword = !_isPassword;
                        });
                      },
                      icon: ImageIcon(
                        AssetImage(
                          _isPassword
                              ? 'assets/icons/eye-slash.png'
                              : 'assets/icons/eye-slash.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'plz enter re password';
                    }
                    if (value != _passwordController.text) {
                      return 'the password is not match';
                    }
                    return null;
                  },
                  obscureText: _isPassword,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Re Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: ImageIcon(
                        AssetImage('assets/images/password_icon.png'),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPassword = !_isPassword;
                        });
                      },
                      icon: ImageIcon(
                        AssetImage(
                          _isPassword
                              ? 'assets/icons/eye-slash.png'
                              : 'assets/icons/eye-slash.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    log('successfully');
                    AuthFirebase.createAccount(
                      email: _emailController.text,
                      password: _passwordController.text,
                      phone: _phoneController.text,
                    ).then(
                      (value) {
                        EasyLoading.dismiss();
                        if (value == true) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            PageRouteName.signIn,
                            (route) => false,
                          );
                        }
                        return false;
                      },
                    );
                  }
                },
                child: Container(
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account ? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColor.black,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

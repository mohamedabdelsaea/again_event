import 'package:again_evently/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: Column(
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
          // Email
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
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
          // Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              obscureText: !_isPasswordVisible,
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
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: ImageIcon(
                    AssetImage(
                      _isPasswordVisible
                          ? 'assets/icons/eye-slash.png'
                          : 'assets/icons/eye-slash.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Re Password
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              obscureText: !_isPasswordVisible,
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
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: ImageIcon(
                    AssetImage(
                      _isPasswordVisible
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
    );
  }
}

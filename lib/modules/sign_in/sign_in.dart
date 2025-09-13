import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isPassword = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Image.asset(
            'assets/images/Logo.png',
            height: size.height * 0.2,
            width: size.width * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              // obscureText: true,
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
              obscureText: !_isPassword,
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
                fillColor: AppColor.primary,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPassword = !_isPassword;
                      });
                    },
                    icon: ImageIcon(AssetImage(
                      _isPassword
                          ? 'assets/icons/eye-slash.png'
                          : 'assets/icons/eye-slash.png',
                    ))),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10),
                  child: ImageIcon(
                    AssetImage('assets/images/password_icon.png'),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, PageRouteName.forgetPassword);
              },
              child: Text(
                'Forget Password?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PageRouteName.layout,
                (route) => false,
              );
            },
            child: Container(
              height: size.height * 0.08,
              width: size.width * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(22)),
              child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don’t Have Account ? ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColor.black,
                ),
              ),
              SizedBox(width: size.width * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, PageRouteName.signUp);
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Divider(
                  color: AppColor.primary,
                  indent: 30,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              Text(
                'Or',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColor.primary,
                ),
              ),
              Expanded(
                child: Divider(
                  color: AppColor.primary,
                  indent: 10,
                  endIndent: 30,
                  thickness: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/google_logo.png',
                    height: 25,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Login With Google',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.white,
                foregroundColor: AppColor.primary,
                side: BorderSide(
                  color: AppColor.primary,
                ),
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

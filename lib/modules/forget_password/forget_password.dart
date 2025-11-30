import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/core/utils/fire_base/auth_firebase.dart';
import 'package:again_evently/main.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final TextEditingController _phoneController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void onCodeSent(String verificationId) {
      navigatorKey.currentState!.pushNamed(PageRouteName.signIn);
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: AppColor.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/forget_password.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                maxLength: 11,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter phone number';
                  }

                  // Remove any spaces
                  String phone = value.trim();

                  // لو بدأ بـ 0 نشيلها
                  if (phone.startsWith('0')) {
                    phone = phone.substring(1);
                  }

                  // لازم يكون 10 أرقام بعد ما نشيل الصفر
                  if (phone.length != 10) {
                    return 'Phone number must be 10 digits (without 0)';
                  }

                  // لازم يبدأ بـ 1
                  if (!phone.startsWith('1')) {
                    return 'Phone must start with 1 (ex: 1156789876)';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Icon(Icons.phone, color: Colors.grey),
                  ),
                  prefixText: '+20 ',
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  hintText: 'Enter phone without 0 (ex: 1156789876)',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColor.primary),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  String phone = _phoneController.text.trim();

                  // لو بدأ بـ 0 نحذفها
                  if (phone.startsWith('0')) {
                    phone = phone.substring(1);
                  }

                  // نكوّن الرقم بصيغة دولية
                  final fullPhone = '+20$phone';

                  AuthFirebase.sendOtpToPhone(
                    phone: fullPhone,
                    onCodeSent: onCodeSent,
                  );
                }
              },
              child: Container(
                height: size.height * 0.08,
                width: size.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

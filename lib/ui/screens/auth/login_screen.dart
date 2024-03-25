import 'package:flutter/material.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/auth/signup_screen.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/screen_background.dart';
import '../bottom_nav_base_screen.dart';
import '../email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _logInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> login() async {
    _logInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text
    };
    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, requestBody);

    _logInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect email or password')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get Started With',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                        },
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordTEController,
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 6) {
                            return 'Please enter a valid password, minimum 6 letters';
                          }
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _logInProgress == false,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: const Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerificationScreen()),
                            );
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text("Sign Up"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

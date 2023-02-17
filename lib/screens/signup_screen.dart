import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livit/resources/auth_methods.dart';
import 'package:livit/responsive/mobile_layout.dart';
import 'package:livit/responsive/resp_layout.dart';
import 'package:livit/responsive/web_layout.dart';
import 'package:livit/screens/login_screen.dart';
import 'package:livit/utils/colors.dart';
import 'package:livit/utils/utils.dart';
import 'package:livit/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(flex: 2, child: Container()),

                      // logo
                      SvgPicture.asset(
                        'assets/livit_logo_full.svg',
                        height: 85,
                      ),
                      const SizedBox(height: 40),

                      // profile picture
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage(
                                    'assets/livit_default_avatar.png',
                                  ),
                                ),
                          Positioned(
                            bottom: -11,
                            left: 79,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                              color: orangeColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // username input
                      TextFieldInput(
                        hintText: 'Enter Username',
                        textInputType: TextInputType.text,
                        textEditingController: _usernameController,
                      ),
                      const SizedBox(height: 20),

                      // email input
                      TextFieldInput(
                        hintText: 'Enter Email',
                        textInputType: TextInputType.emailAddress,
                        textEditingController: _emailController,
                      ),
                      const SizedBox(height: 20),

                      // password input
                      TextFieldInput(
                        hintText: 'Enter Password',
                        textInputType: TextInputType.text,
                        textEditingController: _passwordController,
                        isPass: true,
                      ),
                      const SizedBox(height: 20),

                      // bio input
                      TextFieldInput(
                        hintText: 'Enter Bio (Optional)',
                        textInputType: TextInputType.text,
                        textEditingController: _bioController,
                      ),
                      const SizedBox(height: 20),

                      // signup as artist button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: signUpUser,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  color: orangeColor,
                                ),
                                child: !_isLoading
                                    ? const Text(
                                        'Signup as Artist',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 35),

                          // signup as venue button
                          Expanded(
                            child: InkWell(
                              //onTap: ,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  color: orangeColor,
                                ),
                                child: !_isLoading
                                    ? const Text(
                                        'Signup as Venue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Flexible(flex: 2, child: Container()),

                      // login button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text("Already Registered? "),
                          ),
                          GestureDetector(
                            onTap: navigateToLogin,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
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

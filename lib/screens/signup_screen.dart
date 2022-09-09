import 'dart:typed_data';
import 'package:flutter/material.dart';
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
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
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
      file: _image!,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),

              // logo

              //const SizedBox(height: 64),

              // profile picture
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i1.sndcdn.com/avatars-46GF1rag02JyR6y8-zIUu6w-t500x500.jpg'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // username input
              TextFieldInput(
                hintText: 'Enter Username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 22),

              // email input
              TextFieldInput(
                hintText: 'Enter Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 22),

              // password input
              TextFieldInput(
                hintText: 'Enter Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 22),

              // bio input
              TextFieldInput(
                hintText: 'Enter Bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(height: 22),

              // signup button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    color: Colors.orange,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(height: 22),
              Flexible(flex: 2, child: Container()),

              // // signup button neumorphism
              // InkWell(
              //     onTap: signUpUser,
              //     child: Container(
              //       width: 200.0,
              //       height: 100.0,
              //       color: const Color(0xff333333),
              //       alignment: Alignment.center,
              //       transformAlignment: Alignment.center,
              //       child: Container(
              //         color: const Color(0xff333333),
              //         child: Container(
              //           width: 100,
              //           height: 50,
              //           decoration: BoxDecoration(
              //             color: const Color(0xff333333),
              //             borderRadius: BorderRadius.circular(30),
              //             gradient: const LinearGradient(
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //               colors: [
              //                 Color(0xff333333),
              //                 Color(0xff333333),
              //               ],
              //             ),
              //             boxShadow: const [
              //               BoxShadow(
              //                 color: Color(0xff4c4c4c),
              //                 offset: Offset(-20.4, -20.4),
              //                 blurRadius: 29,
              //                 spreadRadius: 0.0,
              //               ),
              //               BoxShadow(
              //                 color: Color(0xff1a1a1a),
              //                 offset: Offset(20.4, 20.4),
              //                 blurRadius: 29,
              //                 spreadRadius: 0.0,
              //               ),
              //             ],
              //           ),
              //           child: !_isLoading
              //               ? const Text(
              //                   'Sign up',
              //                   style: TextStyle(fontWeight: FontWeight.bold),
              //                 )
              //               : const CircularProgressIndicator(
              //                   color: primaryColor,
              //                 ),
              //         ),
              //       ),
              //     )),
              // const SizedBox(height: 22),
              // Flexible(flex: 2, child: Container()),

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
    );
  }
}

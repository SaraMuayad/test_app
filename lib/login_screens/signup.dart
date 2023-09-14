import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Utils/colors.dart';
import '../services/authentication.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({Key? key}) : super(key: key);

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  Authentication auth = Authentication();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 40)),
        // Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: TextFormField(
        //     controller: usernameController,
        //     onChanged: ((value) {
        //       setState(() {
        //         username = value;
        //         print(username);
        //       });
        //     }),
        //     cursorColor: Colors.black,
        //     // keyboardType: TextInputType.,
        //     decoration: const InputDecoration(
        //       enabledBorder: OutlineInputBorder(
        //         // width: 0.0 produces a thin "hairline" border

        //         borderRadius: BorderRadius.horizontal(
        //             left: Radius.elliptical(20, 20),
        //             right: Radius.elliptical(20, 20)),
        //         borderSide: BorderSide(color: Colors.grey, width: 0.0),
        //       ),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.horizontal(
        //             left: Radius.elliptical(20, 20),
        //             right: Radius.elliptical(20, 20)),
        //       ),
        //       hintStyle: TextStyle(fontSize: 15),
        //       hintText: 'Enter your Username',
        //       prefixIcon: Icon(Icons.person),
        //       contentPadding: EdgeInsets.all(18),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: emailController,
            onChanged: ((value) {
              setState(() {
                email = value;
                print(email);
              });
            }),
            cursorColor: Colors.black,
            // keyboardType: TextInputType.,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border

                borderRadius: BorderRadius.horizontal(
                    left: Radius.elliptical(20, 20),
                    right: Radius.elliptical(20, 20)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.elliptical(20, 20),
                    right: Radius.elliptical(20, 20)),
              ),
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'Enter your Email',
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.all(18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: passwordController,

            onChanged: ((value) {
              setState(() {
                password = value;
                print(password);
              });
            }),
            cursorColor: Colors.black,
            // keyboardType: TextInputType.,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border

                borderRadius: BorderRadius.horizontal(
                    left: Radius.elliptical(20, 20),
                    right: Radius.elliptical(20, 20)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.elliptical(20, 20),
                    right: Radius.elliptical(20, 20)),
              ),
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'Enter your Password',
              prefixIcon: Icon(Icons.password),
              contentPadding: EdgeInsets.all(18),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            dynamic user = await auth.Register(email, password);
            if (user != null) {
              print(user.userid);
            } else {
              print('Register Sinp up avaliable');
            }
          },
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [ColorResources.purple4D5, ColorResources.redD90],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: const Center(
                child: Text(
              "SignUp",
              style: TextStyle(color: Colors.white),
            )),
          ),
        )
      ],
    );
  }
}

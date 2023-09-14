import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_app/services/authentication.dart';

import '../Utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  Authentication auth = Authentication();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = '';
  String password = '';
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 40)),
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
              });
            }),

            cursorColor: Colors.black,
            // keyboardType: TextInputType.,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border

                borderRadius: BorderRadius.horizontal(
                    left: Radius.elliptical(20, 20),
                    right: Radius.elliptical(20, 20)),
                borderSide: BorderSide(color: Colors.grey, width: 0.0),
              ),
              border: const OutlineInputBorder(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () async {
            dynamic user =
                await auth.SingnInWithEmailAndPassword(email, password);
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
                  // begin: Alignment.topLeft,
                  // end: Alignment.topRight,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: const Center(
                child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            )),
          ),
        )
      ],
    );
  }
}

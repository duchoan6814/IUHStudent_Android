import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset("assets/images/Logo_IUH.png"),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5)
                )
              ]
            ),
            child: Column(
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: ColorConfig.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "USERNAME",
                    labelStyle: TextStyle(
                      color: ColorConfig.textColorLight,
                      fontSize: 15.0
                    )
                  ),
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "PASSWORD",
                    labelStyle: TextStyle(
                      color: ColorConfig.textColorLight,
                      fontSize: 15.0
                    )
                  ),
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorConfig.primary),
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.0)),

                  ),
                    onPressed: () => print("login"),
                    child: Text("Login")
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

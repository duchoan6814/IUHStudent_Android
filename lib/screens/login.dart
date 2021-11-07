import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iuh_student/screens/screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String usernameInput = "";
  String passwordInput = "";

  @override
  Widget build(BuildContext context) {
    String queryLogin = """
      mutation LOGIN(\$username: String!, \$password: String!) {
        login(username: \$username, password: \$password) {
          status
          errors {
            message
            error_fields
          }
          message
          data {
            token
          }
        }
      }
    """;

    final storage = new FlutterSecureStorage();

    return Scaffold(
      backgroundColor: Colors.white,
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
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: ColorConfig.character,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0),
                ),
                TextField(
                  onChanged: (value) => setState(() {
                    usernameInput = value;
                  }),
                  decoration: const InputDecoration(
                      labelText: "USERNAME",
                      labelStyle: TextStyle(
                          color: ColorConfig.character, fontSize: 15.0)),
                ),
                TextField(
                  onChanged: (value) => setState(() {
                    passwordInput = value;
                  }),
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "PASSWORD",
                      labelStyle: TextStyle(
                          color: ColorConfig.character, fontSize: 15.0)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Mutation(
                  options: MutationOptions(
                    document: gql(queryLogin),
                    update: (GraphQLDataProxy? cache, QueryResult? result) =>
                        cache,
                    // or do something with the result.data on completion
                    onCompleted: (dynamic resultData) async {
                      // await storage.write(key: "__access__token__", value: value);
                      var errors = resultData?["login"]?["errors"];
                      if (errors != null && !errors.isEmpty) {
                        Fluttertoast.showToast(
                            msg: errors?[0]?["message"],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }

                      var token = resultData?["login"]?["data"]?["token"];
                      await storage.write(
                          key: "__access__token__", value: token);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreeen()));

                      print(resultData);
                    },
                  ),
                  builder: (
                    RunMutation runMutation,
                    QueryResult? result,
                  ) {
                    return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorConfig.primary),
                          minimumSize: MaterialStateProperty.all(
                              Size(double.infinity, 40.0)),
                        ),
                        onPressed: () => runMutation({
                              "username": usernameInput,
                              "password": passwordInput
                            }),
                        child: Text("Login"));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

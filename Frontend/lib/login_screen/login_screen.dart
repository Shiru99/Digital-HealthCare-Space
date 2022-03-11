import 'package:digital_healthcare_space/navigation_home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      fontSize: 16.0);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var userID = null;

  bool _passwordVisible = false;
  bool _isLoading = false;

  bool healthCareWorker = false;

  reset() {
    setState(() {
      _isLoading = true;
    });
  }

  Future getUserID(String email, String password) async {}

  Future signInTheUserGP(
      String email, String password, bool isHealthCareWorker) async {
    if (_signInFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (kDebugMode) {
        print(email + " " + password + " " + isHealthCareWorker.toString());
      }

      // http://127.0.0.1:9000/login/user
      String url = "http://localhost:9000/login/user";

      final http.Response response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'contact': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        userID = json.decode(response.body)['userid'];
        _isLoading = false;

        if (isHealthCareWorker) {
          if (kDebugMode) {
            print("continue as health care worker");
          }
          toastMessage("Welcome, health-care-worker");
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  NavigationHomeScreen(email: email, userID: userID)));
        } else {
          if (kDebugMode) {
            print("Welcome, User");
          }
          toastMessage("Welcome, User");
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  NavigationHomeScreen(email: email, userID: userID)));
        }
      } else {
        toastMessage("Sorry, Something went wrong");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _email.text = 'john.doe@gmail.com';
    _password.text = 'abcABC123@';

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F3F8),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                        "Please login or sign up to continue using our app.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/images/login.png", height: 225),

                    Form(
                      key: _signInFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Gmail",
                                  hintText: "john.doe@gmail.com",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  )),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return EmailValidator.validate(email)
                                    ? null
                                    : "Invalid email address";
                              },
                              onSaved: (value) {
                                _email.text = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            child: TextFormField(
                                // style: TextStyle(
                                //   color: Colors.white,
                                // ),
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: " a-z + A-Z + 0-9 + !@#\$&*~ ",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility // Icons.lock,
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                                controller: _password,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).unfocus(),
                                validator: (password) {
                                  Pattern pattern =
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                  RegExp regex = RegExp(pattern.toString());
                                  if (password!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (password.length < 8) {
                                    return 'atleast 8 characters';
                                  }
                                  if (!regex.hasMatch(password)) {
                                    return 'week password';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _password.text = value!;
                                }),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: healthCareWorker,
                            onChanged: (newValue) {
                              setState(() {
                                healthCareWorker = newValue!;
                              });
                              const Text(
                                "HealthCare Worker",
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xff132137)),
                              );
                            },
                          ),
                          const TextButton(
                            onPressed: null,
                            child: Text(
                              "HealthCare Worker?",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 16,
                        top: 16,
                      ),
                      child: InkWell(
                        onTap: () {
                          signInTheUserGP(
                              _email.text, _password.text, healthCareWorker);
                        },
                        child: Container(
                          height: 58,
                          padding: const EdgeInsets.only(
                            left: 56.0,
                            right: 56.0,
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: const Color(0xff132137),
                          ),
                          child: const Text(
                            "Let's Connect",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    //Text("data"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

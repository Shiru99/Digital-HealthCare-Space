import 'package:digital_healthcare_space/login_screen/utils/appColors.dart';
import 'package:digital_healthcare_space/login_screen/views/SaveUser.dart';
import 'package:digital_healthcare_space/navigation_home_screen.dart';
import 'package:email_validator/email_validator.dart';

import 'package:fluttertoast/fluttertoast.dart';

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

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  late SaveUser _user;
  bool _passwordVisible = false;
  bool _isLoading = false;

  bool health_care_worker = false;

  reset() {
    setState(() {
      _isLoading = true;
    });
  }

  signInTheUserGP(
      String email, String password, bool isHealthCareWorker) async {
    if (_signInFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      print(email + " " + password + " " + isHealthCareWorker.toString());

      // Query to check valid user
      var validUser = true;

      if (validUser) {
        _isLoading = false;

        if (isHealthCareWorker) {
          print("continue as health care worker");
          toastMessage("Welcome, health-care-worker");
          Navigator.pop(context);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
        } else {
          print("Welcome, User");
          toastMessage("Welcome, User");
          Navigator.pop(context);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kLightPink,
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

                    Image.asset("assets/images/img1.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("Welcome",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text("Please login or sign up to continue using our app.",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),

                    Form(
                      key: _signInFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            child: new TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Gmail",
                                  hintText: "john.doe@gmail.com",
                                  hintStyle: const TextStyle(
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
                            child: new TextFormField(
                                // style: TextStyle(
                                //   color: Colors.white,
                                // ),
                                obscureText: _passwordVisible,
                                decoration: new InputDecoration(
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
                                  RegExp regex = new RegExp(pattern.toString());
                                  if (password!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (password.length < 8) {
                                    return 'atleast 8 charater';
                                  }
                                  if (!regex.hasMatch(password))
                                    return 'week password';
                                  else
                                    return null;
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
                            value: health_care_worker,
                            onChanged: (newValue) {
                              setState(() {
                                health_care_worker = newValue!;
                              });
                              const Text(
                                "HealthCare Worker",
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.kDarkBack),
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
                              _email.text, _password.text, health_care_worker);
                        },
                        child: Container(
                          height: 58,
                          padding: EdgeInsets.only(
                            left: 56.0,
                            right: 56.0,
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: AppColors.kDarkBack,
                          ),
                          child: Text(
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

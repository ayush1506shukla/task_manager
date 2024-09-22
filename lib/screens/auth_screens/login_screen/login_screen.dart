import 'package:flutter/material.dart';
import 'package:task_manager/screens/auth_screens/register_screen/register_screen.dart';
import 'package:task_manager/screens/home_screen/root_home_screen.dart';
import 'package:task_manager/services/auth_services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices _authServices = AuthServices();

  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState?.validate() == true) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Try to log in with the provided email and password
      String uid = await _authServices.login(email, password);
      if (uid != "None") {
        // If login successful, navigate to home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => RootHomeScreen()),
        );
      } else {
        // Show error message if login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed. Please check your credentials.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/gifs/auth_gif.gif")),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25))
                        ],
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenWidth / 3.312)),
                    width: screenWidth / 3.312,
                    height: screenWidth / 3.312,
                  ),
                  SizedBox(
                    height: screenWidth / 20.7,
                  ),
                  Text(
                    "User Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: screenWidth / 20.7,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenWidth / 5.83,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth / 12.54),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Email",
                          prefixIcon: Icon(Icons.mail)),
                    ),
                  ),
                  SizedBox(height: screenWidth / 18),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth / 12.54),
                    child: TextFormField(
                      obscureText: _hidePassword,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: _hidePassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                          prefixIcon: Icon(Icons.lock)),
                    ),
                  ),
                  SizedBox(height: screenWidth / 9.63),
                  Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / 10.35)))),
                        onPressed: _login,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 20.7),
                        )),
                    width: screenWidth / 2.36,
                    height: screenWidth / 8.28,
                  ),
                  SizedBox(
                    height: screenWidth / 20.7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: screenWidth / 31.84),
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: screenWidth / 31.84,
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

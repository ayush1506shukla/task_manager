import 'package:flutter/material.dart';
import 'package:task_manager/screens/auth_screens/login_screen/login_screen.dart';
//import 'package:task_manager/screens/home_screen/root_home_screen.dart';
import 'package:task_manager/services/auth_services/auth_services.dart';
import 'package:task_manager/services/database_services/user_services.dart';
import 'package:task_manager/models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _hidePassword = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();
  final UserServices _userServices = UserServices();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _submitFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  Future<void> _register() async {
    if (_formKey.currentState?.validate() == true) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String userName = _nameController.text.trim();

      // Register user with email and password
      String uid = await _authServices.register(email, password);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>LoginScreen()));
      if (uid != "None") {
        // Create AppUser instance
        AppUser appUser = AppUser(uid: uid, userName: userName, email: email, password: password);
        
        // Add user data to Firestore
        await _userServices.addUserDataToDatabase(appUser);

        // Navigate to login screen after successful registration
        
      } else {
        // Handle registration failure (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed. Please try again.")),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _submitFocusNode.dispose();
    super.dispose();
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
                    "Register Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: screenWidth / 20.7,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenWidth / 5.6,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth / 12.54),
                    child: TextFormField(
                      key: _nameKey,
                      controller: _nameController,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Name is required";
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (_) {
                        if (_nameKey.currentState?.validate() == true) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Name*",
                          prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                  SizedBox(height: screenWidth / 18),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth / 12.54),
                    child: TextFormField(
                      focusNode: _emailFocusNode,
                      key: _emailKey,
                      controller: _emailController,
                      onFieldSubmitted: (_) {
                        if (_emailKey.currentState?.validate() == true) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        }
                      },
                      validator: (value) {
                        if (value.toString().trim().isNotEmpty) {
                          if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value.toString().trim())) {
                            return "Enter Valid Email";
                          } else {
                            return null;
                          }
                        } else {
                          return "Email is required";
                        }
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
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      key: _passwordKey,
                      onFieldSubmitted: (_) {
                        if (_passwordKey.currentState?.validate() == true) {
                          FocusScope.of(context).requestFocus(_submitFocusNode);
                        }
                      },
                      validator: (value) {
                        if (value.toString().trim().isNotEmpty) {
                          if (value.toString().trim().length >= 6) {
                            return null;
                          } else {
                            return "Password length must be at least 6";
                          }
                        } else {
                          return "Password is required";
                        }
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
                        focusNode: _submitFocusNode,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / 10.35)))),
                        onPressed: _register,
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
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
                          builder: (context) => LoginScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: screenWidth / 31.84),
                        ),
                        Text(
                          " Login",
                          style: TextStyle(
                              fontSize: screenWidth / 31.84,
                              decoration: TextDecoration.underline,
                              color:Colors.blue),
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

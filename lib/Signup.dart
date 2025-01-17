import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soretras/Signin.dart';
import 'package:soretras/navbar.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<Signup> {
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('compte');
  late TextEditingController _nomController;
  late TextEditingController _telController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController1;
  late TextEditingController _passwordController2;
  late FocusNode _nomFocusNode;
  late FocusNode _telFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode1;
  late FocusNode _passwordFocusNode2;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _telController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController1 = TextEditingController();
    _passwordController2 = TextEditingController();
    _nomFocusNode = FocusNode();
    _telFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode1 = FocusNode();
    _passwordFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _telController.dispose();
    _emailController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
    _nomFocusNode.dispose();
    _telFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode1.dispose();
    _passwordFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_nomFocusNode.canRequestFocus ||
            _telFocusNode.canRequestFocus ||
            _emailFocusNode.canRequestFocus ||
            _passwordFocusNode1.canRequestFocus ||
            _passwordFocusNode2.canRequestFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/sntri.png',
                        width: 69,
                        height: 68,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Sign Up !',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          elevation: 2,
        ),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _nomController,
                focusNode: _nomFocusNode,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your Name',
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _telController,
                focusNode: _telFocusNode,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'N° Téléphone',
                  hintText: 'Enter your Numéro',
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _passwordController1,
                focusNode: _passwordFocusNode1,
                obscureText: !_passwordVisible1,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible1
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible1 = !_passwordVisible1;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _passwordController2,
                focusNode: _passwordFocusNode2,
                obscureText: !_passwordVisible2,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible2
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible2 = !_passwordVisible2;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle sign up
                  _signUp(context);
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16),
              Center(
                child: InkWell(
                  onTap: () {
                    // Navigate to sign in screen
                    Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => Signin()),
                    );
                  },
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                      color: Colors.green, // Change this to your desired color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    // Get the user data from the text fields
    String name = _nomController.text;
    String number = _telController.text;
    String email = _emailController.text;
    String password = _passwordController1.text;
    String confirmPassword = _passwordController2.text;

    // Check if password and confirm password match
    if (password != confirmPassword) {
      // Show notification if passwords don't match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return; // Exit the method
    }

    try {
      // Create user with email and password using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the Firebase User object
      User? user = userCredential.user;

      // Check if user is null
      if (user != null) {
        // User creation successful, store additional data in Firebase Realtime Database
        await _userRef.child(number).set({
          'name': name,
          'email': email,
          'pass': password,
        });

        // Sign-up successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up successful')),
        );
        Navigator.of(context).push(
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => Navbar()),
        );
      }
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }
}

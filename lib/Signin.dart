import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:soretras/Signup.dart';
import 'package:soretras/Verify.dart';
import 'package:soretras/navbar.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<Signin> {
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('compte');
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late FocusNode _phoneFocusNode;
  late FocusNode _passwordFocusNode;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_phoneFocusNode.canRequestFocus ||
            _passwordFocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green, // Change this to your desired color
          automaticallyImplyLeading: false,
          title: const Text(
            'Soretras',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.green, // Change this to your desired color
                    fontSize: 45,
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telephone',
                    hintText: 'Enter your phone number',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  autofocus: false,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    check(context);
                  },
                  // Handle sign in
                  //  Navigator.of(context).push(
                  //   MaterialPageRoute<dynamic>(builder: (BuildContext context) => Navbar()),
                  //);
                  //},
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigate to forgot password screen
                    Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => Verify()),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.green, // Change this to your desired color
                    ),
                  ),
                ),
                const Text('Or'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle Facebook sign in
                      },
                      icon: Icon(Icons.facebook),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle email sign in
                      },
                      icon: Icon(Icons.mail),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle Apple sign in
                      },
                      icon: Icon(Icons.apple_sharp),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Navigate to sign up screen

                    Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => Signup()),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: Colors.green, // Change this to your desired color
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/sntri.png',
                    width: 242,
                    height: 224,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> check(BuildContext context) async {
    String number = _phoneController.text;
    String password = _passwordController.text;
    _userRef.onValue.listen((event) {
      Object? data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        if (data.containsKey(number)) {
          // Number exists, now check password
          Map<dynamic, dynamic> userData = data[number];
          if (userData['pass'] == password) {
            final user = userData['name'];
            // Password matches, navigate to Navbar
            Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => Navbar()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('welcome $user')),
            );
          } else {
            // Password does not match
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password incorrect')),
            );
          }
        } else {
          // Number does not exist
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account doesn\'t exist')),
          );
        }
      }
    });
  }
}

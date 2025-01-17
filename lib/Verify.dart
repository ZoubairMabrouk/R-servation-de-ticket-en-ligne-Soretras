import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyWidgetState();
}

class _VerifyWidgetState extends State<Verify> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late FocusNode _textFieldFocusNode1;
  late FocusNode _textFieldFocusNode2;

  @override
  void initState() {
    super.initState();
    _textController1 = TextEditingController();
    _textFieldFocusNode1 = FocusNode();
    _textController2 = TextEditingController();
    _textFieldFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textFieldFocusNode1.dispose();
    _textController2.dispose();
    _textFieldFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _textFieldFocusNode1.unfocus();
        _textFieldFocusNode2.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Verification',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'Enter your phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.green,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Container(
                  width: 250,
                  child: TextFormField(
                    controller: _textController1,
                    focusNode: _textFieldFocusNode1,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      hintText: 'Phone number',
                      hintStyle: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      // Implement your validation logic here
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(250, 40),
                  ),
                  child: Text(
                    'Send code',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  'Enter verification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Colors.green,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Container(
                  width: 250,
                  child: TextFormField(
                    controller: _textController2,
                    focusNode: _textFieldFocusNode2,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Verification',
                      labelStyle: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      hintText: '6-digit code',
                      hintStyle: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      // Implement your validation logic here
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      'Signin',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(250, 40),
                  ),
                  child: Text(
                    'Send code',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14),
                child: GestureDetector(
                  onTap: () {
                    // Implement resend code functionality
                  },
                  child: Text(
                    'Resend verification code!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Colors.green,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
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
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/heloper/helper.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formKeyemail = GlobalKey<FormState>();

  bool validateEmail(String email) {
    // Regular expression pattern for email validation
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the provided email matches the regex pattern
    return emailRegex.hasMatch(email);
  }

  bool show = false;
  bool show2 = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  GlobalKey<FormState> key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: key1,
            child: Column(
              children: [
                SizedBox(
                  height: s.height * 0.1,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's get started by filling out the form below.",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.6)
                        // fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.05,
                ),
                // Generated code for this emailAddress_Create Widget...
                Form(
                  key: _formKeyemail,
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: email,
                      // autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          _formKeyemail.currentState!.validate();
                        });
                      },
                      autofillHints: [AutofillHints.email],
                      validator: (value) {
                        if (!validateEmail(value!)) {
                          return 'Please enter valid email';
                        }
                      },
                      obscureText: false,
                      // style: TextStyle(color: Colors.black.withOpacity(0.6),),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.6)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4B39EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(24),
                      ),
                      minLines: null,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,

                      cursorColor: Color(0xFF4B39EF),
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                TextFormField(
                  controller: pass,
                  // autofocus: true,
                  // autofillHints: [AutofillHints.email],
                  obscureText: show,
                  // style: TextStyle(color: Colors.black.withOpacity(0.6),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      child: Icon(
                        show ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    labelStyle:
                        TextStyle(color: Colors.black.withOpacity(0.6)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF4B39EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(24),
                  ),
                  // minLines: null,
                  // keyboardType: TextInputType.visiblePassword,
                  cursorColor: Color(0xFF4B39EF),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                TextFormField(
                  controller: pass2,
                  // autofocus: true,
                  // autofillHints: [AutofillHints.email],
                  obscureText: show2,
                  validator: (value) {
                    if (value != pass.text) {
                      return "Please enter same password";
                    }
                  },
                  // style: TextStyle(color: Colors.black.withOpacity(0.6),),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          show2 = !show2;
                        });
                      },
                      child: Icon(
                        show2 ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    labelStyle:
                        TextStyle(color: Colors.black.withOpacity(0.6)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF4B39EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(24),
                  ),
                  // minLines: null,
                  // keyboardType: TextInputType.visiblePassword,
                  cursorColor: Color(0xFF4B39EF),
                ),
                SizedBox(
                  height: s.height * 0.03,
                ),
                InkWell(
                  onTap: () async {
                    if(key1.currentState!.validate() || _formKeyemail.currentState!.validate()){
                    var data = await ApiHelper.apihelper
                        .createUserWithEmailAndPassword(
                            email: email.text, pass: pass.text);
                    log("$data");
                    if (data.runtimeType == String) {
                      Get.snackbar("Error!", "$data",
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }else{
                      ApiHelper.apihelper.setdata(userId: data.user?.uid);
                      Get.offAllNamed('/home');
                    }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: s.width * 0.15, vertical: 16),
                    decoration: BoxDecoration(
                        color: Color(0xff5949F0),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Or sign up with",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)
                        // fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                InkWell(
                  onTap: () async {
                    var data =
                        await ApiHelper.apihelper.signInWithGoogle();
                    log('${data.user?.uid}');
                    if (data != null) {
                      ApiHelper.apihelper.setdata(userId: '${data.user?.uid}');
                      Get.offAllNamed('/home');
                    } else {
                      Get.snackbar("Error!", "please try aging",
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }

                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        // color: Color(0xff5949F0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("asstes/image/gg.png",
                          height: s.height * 0.03,
                        ),

                        SizedBox(
                          width: s.width * 0.02,
                        ),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

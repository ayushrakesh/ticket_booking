import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ticket_booking/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final height = Get.height;
  final width = Get.width;

  final emailCtl = TextEditingController();
  final passCtl = TextEditingController();
  final confCtl = TextEditingController();
  final userCtl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLogin = true;
  bool isLoading = false;

  String? username;
  String? email;
  String? confPassword;
  String? password;

  void submitForm(
      String? emai, String? usern, String? passw, String? confPass) async {
    setState(() {
      isLoading = true;
    });

    if (!isLogin) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emai!,
          password: passw!,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({'email': emai, 'username': usern});

        print(credential.user!.email);
        print(credential.user!.displayName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emai!, password: password!);
        print(credential.user!.email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        print(e);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

// void getData()async{
//  final stram=await FirebaseFirestore.instance.collection('tickets').snapshots();
//  final  docments=stram.da
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 9, 39, 213),
            Color.fromARGB(255, 140, 154, 232),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: height * 0.04, vertical: height * 0.04),
            child: Column(
              children: [
                Gap(height * 0.1),
                isLogin
                    ? Text(
                        'Welcome Back',
                        style: TextStyle(
                            letterSpacing: 0.8,
                            color: Styles.bgColor,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        'Register',
                        style: TextStyle(
                            letterSpacing: 0.8,
                            color: Styles.bgColor,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                isLogin
                    ? Text(
                        'Login to your account',
                        style: TextStyle(
                            fontSize: 20,
                            color: Styles.bgColor,
                            fontWeight: FontWeight.w300),
                      )
                    : Text(
                        'Create your account',
                        style: TextStyle(
                            fontSize: 20,
                            color: Styles.bgColor,
                            fontWeight: FontWeight.w300),
                      ),
                Gap(height * 0.06),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailCtl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!value!.contains('@')) {
                            return 'Please provide a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Styles.primaryColor, letterSpacing: 0.7),
                          fillColor: Colors.indigo.shade100,
                          filled: true,
                          errorStyle: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 235, 195, 75),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.08),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // disabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // errorBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                      ),
                      Gap(height * .04),
                      if (!isLogin)
                        Column(
                          children: [
                            TextFormField(
                              controller: userCtl,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username must not be empty';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 14,
                                  color:
                                      const Color.fromARGB(255, 235, 195, 75),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Username',
                                hintStyle: TextStyle(
                                    color: Styles.primaryColor,
                                    letterSpacing: 0.7),
                                fillColor: Colors.indigo.shade100,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: height * 0.02,
                                    horizontal: width * 0.08),
                                // focusedBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // enabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // disabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // errorBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                              ),
                            ),
                            Gap(height * 0.04),
                          ],
                        ),
                      TextFormField(
                        controller: passCtl,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 235, 195, 75),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Styles.primaryColor, letterSpacing: 0.7),
                          fillColor: Colors.indigo.shade100,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.08),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // disabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          // errorBorder: OutlineInputBorder(
                          //   borderSide: BorderSide.none,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                      ),
                      Gap(height * 0.05),
                      if (!isLogin)
                        Column(
                          children: [
                            TextFormField(
                              controller: confCtl,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (!(value == password)) {
                                  return 'Password does not matched';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  confPassword = value;
                                });
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 14,
                                  color:
                                      const Color.fromARGB(255, 235, 195, 75),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    color: Styles.primaryColor,
                                    letterSpacing: 0.7),
                                fillColor: Colors.indigo.shade100,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                  horizontal: width * 0.08,
                                ),
                                // focusedBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // enabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // disabledBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // errorBorder: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                              ),
                            ),
                            Gap(height * 0.08),
                          ],
                        ),
                      isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 2, 9, 65),
                                      Color.fromARGB(255, 14, 31, 163)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  // backgroundColor: Color.fromARGB(255, 2, 9, 65),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.3,
                                      vertical: height * 0.02),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    email!.trim();
                                    password!.trim();
                                    if (confPassword != null) {
                                      confPassword!.trim();
                                    }
                                    if (username != null) {
                                      username!.trim();
                                    }

                                    emailCtl.clear();
                                    passCtl.clear();
                                    confCtl.clear();
                                    userCtl.clear();

                                    submitForm(email, username, password,
                                        confPassword);
                                    // print(username);
                                    // print(email);
                                    // print(password);
                                    // print(confPassword);
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                                child: Text(
                                  isLogin ? 'LOGIN' : 'REGISTER',
                                  style: TextStyle(
                                      color: Styles.bgColor,
                                      letterSpacing: 0.6),
                                ),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLogin
                                ? 'Don\'t have an account? '
                                : 'Already have an account?',
                            style: TextStyle(color: Styles.bgColor),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            style: TextButton.styleFrom(),
                            child: Text(
                              isLogin ? 'Sign up' : 'Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 248, 194, 212)),
                            ),
                          ),
                        ],
                      )
                    ],
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

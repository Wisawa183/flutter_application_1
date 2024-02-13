import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  TextEditingController passwordController = TextEditingController();
  CollectionReference emailLogin =
      FirebaseFirestore.instance.collection("Profile");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text("สร้างบัญชีผู้ใช้"),
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("อีเมล", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                            EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (var email) {
                            profile.email = email!;
                          },
                        ),
                        SizedBox(height: 15),
                        Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          controller: passwordController,
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                          obscureText: true,
                          onSaved: (var password) {
                            profile.password = password;
                          },
                        ),
                        SizedBox(height: 15),
                        Text("ยืนยันรหัสผ่าน", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          validator: (confirmation) {
                            if (confirmation != passwordController.text) {
                              return "รหัสผ่านไม่ตรงกัน";
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: profile.email,
                                    password: profile.password,
                                  )
                                      .then((value) {
                                    Fluttertoast.showToast(
                                      msg: "สร้างบัญชีผู้ใช้สำเร็จ",
                                      gravity: ToastGravity.TOP,
                                    );

                                    formKey.currentState!.reset();
                                    Future.delayed(
                                      Duration(milliseconds: 750),
                                      () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Homescreen();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  });
                                  await emailLogin.add({
                                    "Username": profile.email,
                                    "Email": profile.email,
                                  });
                                } on FirebaseAuthException catch (e) {
                                  print(e.code);
                                  String message = "";
                                  if (e.code == 'email-already-in-use') {
                                    message =
                                        "อีเมลนี้มีการใช้งานแล้วในบัญชีอื่น โปรดใช้อีเมลอื่นแทน!";
                                  } else if (e.code == 'weak-password') {
                                    message =
                                        "รหัสผ่านต้องมีความยาว 8 ตัวอักษรขึ้นไป";
                                  } else {
                                    message = e.message!;
                                  }
                                  Fluttertoast.showToast(
                                    msg: message,
                                    gravity: ToastGravity.TOP,
                                  );
                                }
                              }
                            },
                            child: Text("ลงทะเบียน",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

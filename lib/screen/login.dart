import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/button_nav.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../model/profile.dart';

class LoginScreen extends StatelessWidget {
  final fromKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
              title: Text("เข้าสู่ระบบ"),
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: fromKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("อีเมล", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                            EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (var email) {
                            profile.email = email!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                          obscureText: true,
                          onSaved: (var password) {
                            profile.password = password;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (fromKey.currentState!.validate()) {
                                fromKey.currentState!.save();
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: profile.email,
                                    password: profile.password,
                                  )
                                      .then((value) {
                                    fromKey.currentState!.reset();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => bottombar(),
                                      ),
                                    );
                                  });
                                } on FirebaseAuthException catch (e) {
                                  print(e.code);
                                  String messagelogin = "";
                                  if (e.code == 'wrong-password') {
                                    messagelogin = "รหัสผ่านไม่ถูกต้อง!";
                                  } else if (e.code == 'too-many-requests') {
                                    messagelogin = "รหัสผ่านไม่ถูกต้อง!";
                                  } else if (e.code == 'user-not-found') {
                                    messagelogin = "ไม่พบบัญชีผู้ใช้งานนี้!";
                                  } else {
                                    messagelogin = e.message!;
                                  }
                                  Fluttertoast.showToast(
                                      msg: messagelogin,
                                      gravity: ToastGravity.TOP);
                                }
                              }
                            },
                            child: Text("ลงชื่อเข้าใช้",
                                style: TextStyle(fontSize: 20)),
                          ),
                        )
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

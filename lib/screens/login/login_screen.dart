import 'package:flutter/material.dart';

import 'package:ta2set_app/models/user.dart';
import 'package:ta2set_app/screens/home/homepage_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _usernameFocusNode = FocusNode();
    final _passwordFocusNode = FocusNode();
    final _buttonFocuseNode = FocusNode();
    String _usernameText = '';
    String _passwordText = '';

    Future<void> submit() async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        print(_usernameText);

        print(_passwordText);
        print(await User().login(_usernameText.trim(), _passwordText.trim()) ==
            1);

        if (await User().login(_usernameText.trim(), _passwordText.trim()) ==
            1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => HomePage()));
        } else if (await User()
                .login(_usernameText.trim(), _passwordText.trim()) ==
            -1) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text(
                '!الرجاء ادخال اسم المستخدم و كلمة المرور بطريقة صحيحة',
                style: TextStyle(
                    color: Colors.blue[900], fontWeight: FontWeight.bold),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('حسنا'),
                )
              ],
            ),
            barrierDismissible: false,
          );
        }

        form.reset();
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .4,
              child: FittedBox(
                child: Text(
                  "تقسيط",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Container(
                              /* =================  اسم المسيتخدم ===============================
                        =========================================================*/
                              child: TextFormField(
                                onEditingComplete: () {
                                  submit();
                                },
                                focusNode: _usernameFocusNode,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: "اسم المستخدم",
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                validator: (value) {
                                  if (value != null && value.length < 2) {
                                    return "بالرجاء أدخال اسم المستخدم بطريقة صحيحة";
                                  } else
                                    return null;
                                },
                                onSaved: (value) => _usernameText = value,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Container(
                              /* =================  اسم المسيتخدم ===============================
                        =========================================================*/
                              child: TextFormField(
                                onEditingComplete: () {
                                  submit();
                                },
                                obscureText: true,
                                focusNode: _passwordFocusNode,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: "كلمة المرور",
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  disabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                validator: (value) {
                                  if (value != null && value.length < 2) {
                                    return "بالرجاء أدخال كلمة المرور بطريقة صحيحة";
                                  } else
                                    return null;
                                },
                                onSaved: (value) => _passwordText = value,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .1,
                                right: MediaQuery.of(context).size.width * .1),
                            child: ElevatedButton(
                              focusNode: _buttonFocuseNode,
                              child: FittedBox(
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              onPressed: submit,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

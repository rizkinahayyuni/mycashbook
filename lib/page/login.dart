import 'package:flutter/material.dart';
import 'package:lsp_jti/widgets/showDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  late String _username, _password;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    doLogin() async {
      final form = formKey.currentState;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("username", "user");
      prefs.setString("password", "user");

      if (form!.validate()) {
        form.save();

        if (_username == prefs.getString("username") &&
            _password == prefs.getString("password")) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          String title = 'Login Gagal';
          String content =
              'Username dan Password Salah. Harap periksa kembali Username dan Password anda.';
          showDialogMassage(context, title, content);
        }
      } else {
        String title = 'Gagal Login';
        String content = 'Username dan Password tidak boleh kosong.';
        showDialogMassage(context, title, content);
      }
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 5.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
                width: 277,
                height: 170,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  'images/logo.png',
                ))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: const Text(
                  "My Cash Book",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          controller: _nameController,
                          onSaved: (value) => _username = value!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username tidak boleh kosong.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF7BBA4A)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF7BBA4A)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            hintText: 'Masukkan Username Anda',
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          onSaved: (value) => _password = value!,
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password tidak boleh kosong.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF7BBA4A)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF7BBA4A)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Colors.grey,
                              focusColor: const Color(0xFF7BBA4A),
                            ),
                            hintText: 'Masukkan Password Anda',
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          obscureText: _secureText,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7BBA4A),
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: doLogin,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 16,
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

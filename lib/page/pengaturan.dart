import 'package:flutter/material.dart';
import 'package:lsp_jti/widgets/showDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  final formKey = GlobalKey<FormState>();

  late String _passwordPrev, _passwordNew;

  TextEditingController _passwordPrevController = TextEditingController();
  TextEditingController _passwordNewController = TextEditingController();

  bool _secureText1 = true;
  bool _secureText2 = true;

  showHide1() {
    setState(() {
      _secureText1 = !_secureText1;
    });
  }

  showHide2() {
    setState(() {
      _secureText2 = !_secureText2;
    });
  }

  @override
  void dispose() {
    _passwordPrevController.dispose();
    _passwordNewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    doChangePassword() async {
      final form = formKey.currentState;

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (form!.validate()) {
        form.save();

        if (_passwordPrev == prefs.getString("password")) {
          prefs.setString("password", _passwordNew);
          setState(() {
            _passwordPrevController = TextEditingController(text: null);
            _passwordNewController = TextEditingController(text: null);
            _secureText1 = true;
            _secureText2 = true;
          });
          String title = 'Password Berhasil Diubah';
          String content = 'Password anda sudah berhasil diubah.';
          showDialogMassage(context, title, content);
        } else {
          String title = 'Gagal Mengganti Password';
          String content =
              'Password Lama Salah. Harap periksa kembali Password anda.';
          showDialogMassage(context, title, content);
        }
      } else {
        String title = 'Gagal Mengganti Password';
        String content = 'Password lama dan Password baru tidak boleh kosong.';
        showDialogMassage(context, title, content);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: const Text(
                "Ganti Password",
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
                        "Password Saat Ini",
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
                        controller: _passwordPrevController,
                        onSaved: (value) => _passwordPrev = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password Saat Ini tidak boleh kosong.";
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
                            onPressed: showHide1,
                            icon: Icon(_secureText1
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.grey,
                            focusColor: const Color(0xFF7BBA4A),
                          ),
                          hintText: 'Masukkan Password Saat Ini Anda',
                          hintStyle:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        obscureText: _secureText1,
                        enableSuggestions: false,
                        autocorrect: false,
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
                        "Password Baru",
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
                        onSaved: (value) => _passwordNew = value!,
                        controller: _passwordNewController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password Baru tidak boleh kosong.";
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
                            onPressed: showHide2,
                            icon: Icon(_secureText2
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: Colors.grey,
                            focusColor: const Color(0xFF7BBA4A),
                          ),
                          hintText: 'Masukkan Password Baru Anda',
                          hintStyle:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        obscureText: _secureText2,
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
                onPressed: doChangePassword,
                child: const Text(
                  'SIMPAN',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/rizkina.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "About this App",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Aplikasi ini dibuat oleh :",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nama : Rizkina Hayyuni Putri",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "NIM : 1941720008",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tanggal : 29 September 2022",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

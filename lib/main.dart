import 'package:flutter/material.dart';
import 'package:lsp_jti/page/detail.dart';
import 'package:lsp_jti/page/home.dart';
import 'package:lsp_jti/page/login.dart';
import 'package:lsp_jti/page/pemasukan.dart';
import 'package:lsp_jti/page/pengaturan.dart';
import 'package:lsp_jti/page/pengeluaran.dart';

void main() {
  // runApp(const MyApp());
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFF7BBA4A),
        // secondary: Colors.purple,
      ),
      // backgroundColor: Colors.grey,
    ),
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (context) => const LoginPage(),
      '/home': (context) => const HomePage(),
      '/pemasukan': (context) => const PemasukanPage(),
      '/pengeluaran': (context) => const PengeluaranPage(),
      '/detail': (context) => DetailPage(),
      '/pengaturan': (context) => const PengaturanPage(),
    },
  ));
}

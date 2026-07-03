import 'package:app_taller1/screens/Home.dart';
import 'package:app_taller1/screens/PantallaInicioSesion.dart';
import 'package:app_taller1/screens/PantallaRegistro.dart';
import 'package:app_taller1/screens/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://knllwrjqwdsztpfibcne.supabase.co',
    publishableKey: 'sb_publishable_pvLVPcinbD58ZHZXky3a7g_4mid3sPL',
  );
  runApp(const Taller1());
}

final supabase = Supabase.instance.client;

class Taller1 extends StatefulWidget {
  const Taller1({super.key});

  @override
  State<Taller1> createState() => _Taller1State();
}

class _Taller1State extends State<Taller1> {
  bool modoOscuro = true;

  void cambiarTema() {
    setState(() {
      modoOscuro = !modoOscuro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
        '/home': (context) => Home(),
        '/InicioSesion': (context) => PantallaIniciosesion(),
        '/Registro': (context) => Registro(),
      },
    );
  }
}


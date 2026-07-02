import 'package:app_taller1/screens/Home.dart';
import 'package:app_taller1/screens/PantallaInicioSesion.dart';
import 'package:app_taller1/screens/PantallaPeliculas.dart';
import 'package:app_taller1/screens/PantallaRegistro.dart';
import 'package:app_taller1/screens/PantallaReproductor.dart';
import 'package:app_taller1/screens/Welcome.dart'; // Importa la nueva pantalla
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

class Taller1 extends StatelessWidget {
  const Taller1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome', 
      routes: {
        '/welcome': (context) => const Welcome(), 
        '/home': (context) => Home(),
        '/InicioSesion': (context) => PantallaIniciosesion(),
        '/Peliculas': (context) => PantallaPeliculas(),
        '/Reproductor': (context) => PantallaReproductor(),
        '/Registro': (context) => Registro(), 
      },
    );
  }
}
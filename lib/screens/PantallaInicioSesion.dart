import 'package:app_taller1/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 
class PantallaIniciosesion extends StatefulWidget {
  const PantallaIniciosesion({super.key});
 
  @override
  State<PantallaIniciosesion> createState() => _PantallaIniciosesionState();
}
 
class _PantallaIniciosesionState extends State<PantallaIniciosesion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Iniciar Sesión",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Ingresa tus credenciales para continuar",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 50),
              inputIniciarSesion(context),
            ],
          ),
        ),
      ),
    );
  }
}
 
Widget inputIniciarSesion(BuildContext context) {
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasenia = TextEditingController();
 
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: correo,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: "Correo electrónico",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: contrasenia,
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          labelText: "Contraseña",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 40),
      FilledButton(
        onPressed: () => login(context, correo, contrasenia),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.shade800,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Text(
          "Iniciar Sesión",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
 
Future<void> login(context, correo, contrasenia) async {
  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: correo.text.trim(),
      password: contrasenia.text.trim(),
    );
   
    Navigator.pushReplacementNamed(context, "/home");
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text("Error de Autenticación", style: TextStyle(color: Colors.white)),
        content: Text(e.toString(), style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.red)),
          )
        ],
      ),
    );
  }
}
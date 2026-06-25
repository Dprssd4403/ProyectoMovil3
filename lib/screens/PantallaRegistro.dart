import 'package:app_taller1/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

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
              const SizedBox(height: 20),
              const Text(
                "Crear Cuenta",
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
                "Regístrate para comenzar a ver tus películas",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 40),
              formulario(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget formulario(BuildContext context) {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido =
      TextEditingController(); // Añadido al formulario
  TextEditingController correo = TextEditingController();
  TextEditingController telefono =
      TextEditingController(); // Añadido al formulario
  TextEditingController fechaNacimiento =
      TextEditingController(); // Añadido al formulario
  TextEditingController pais = TextEditingController(); // Añadido al formulario
  TextEditingController generoFavorito =
      TextEditingController(); // Añadido al formulario
  TextEditingController contrasenia = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // CAMPO: NOMBRE
      TextField(
        controller: nombre,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(Icons.person_outline, color: Colors.white54),
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
          labelText: "Ingresa nombre",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: APELLIDO (Añadido)
      TextField(
        controller: apellido,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(Icons.person_outline, color: Colors.white54),
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
          labelText: "Ingresa apellido",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: CORREO ELECTRÓNICO
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
          labelText: "Ingresa un correo electrónico",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: TELÉFONO (Añadido)
      TextField(
        controller: telefono,
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(Icons.phone_outlined, color: Colors.white54),
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
          labelText: "Ingresa tu teléfono",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: FECHA DE NACIMIENTO (Añadido - Nota: Requiere formato AAAA-MM-DD para evitar errores)
      TextField(
        controller: fechaNacimiento,
        keyboardType: TextInputType.datetime,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: Colors.white54,
          ),
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
          labelText: "Fecha de nacimiento (AAAA-MM-DD)",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: PAÍS (Añadido)
      TextField(
        controller: pais,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(Icons.public, color: Colors.white54),
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
          labelText: "Ingresa tu país",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: GÉNERO FAVORITO (Añadido)
      TextField(
        controller: generoFavorito,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          prefixIcon: const Icon(
            Icons.movie_filter_outlined,
            color: Colors.white54,
          ),
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
          labelText: "Género de películas favorito",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 20),

      // CAMPO: CONTRASEÑA
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
          labelText: "Ingresa una contraseña",
          labelStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      const SizedBox(height: 40),

      FilledButton(
        onPressed: () async {
          await registro(
            context,
            nombre,
            apellido,
            correo,
            telefono,
            fechaNacimiento,
            pais,
            generoFavorito,
            contrasenia,
          );
          irInicioSesion(
            context,
            nombre,
            apellido,
            correo,
            telefono,
            fechaNacimiento,
            pais,
            generoFavorito,
            contrasenia,
          );
        },
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
          "Registrarse",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

void irInicioSesion(
  BuildContext context,
  nombre,
  apellido,
  correo,
  telefono,
  fechaNacimiento,
  pais,
  generoFavorito,
  contrasenia,
) {
  try {
    String name = nombre.text;
    String lastName = apellido.text;
    String email = correo.text;
    String phone = telefono.text;
    DateTime birthDate = DateTime.parse(fechaNacimiento.text);
    String country = pais.text;
    String favoriteGenre = generoFavorito.text;
    String password = contrasenia.text;
    Navigator.pushNamed(
      context,
      "/InicioSesion",
      arguments: {
        "nombre": name,
        "apellido": lastName,
        "correo": email,
        "telefono": phone,
        "fechaNacimiento": birthDate,
        "pais": country,
        "generoFavorito": favoriteGenre,
        "contrasenia": password,
      },
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: const Text("Error"), content: Text(e.toString())),
    );
  }
}

Future<void> registro(
  context,
  nombre,
  apellido,
  correo,
  telefono,
  fechaNacimiento,
  pais,
  generoFavorito,
  contrasenia,
) async {
  final AuthResponse res = await supabase.auth.signUp(
    email: correo.text,
    password: contrasenia.text,
    data: {
      'nombre': nombre.text,
      'apellido': apellido.text,
      'telefono': telefono.text,
      'fecha_nacimiento': DateTime.parse(fechaNacimiento.text).toIso8601String(),
      'pais': pais.text,
      'genero_favorito': generoFavorito.text,
    },
  );
  final Session? session = res.session;
  final User? user = res.user;
}

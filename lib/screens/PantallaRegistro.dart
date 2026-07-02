import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0),
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
                style: TextStyle(color: Colors.white54, 
                fontSize: 14),
              ),
              const SizedBox(height: 40),
              const FormularioRegistro(),
            ],
          ),
        ),
      ),
    );
  }
}
<<<<<<< HEAD
 
class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({super.key});
 
  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
=======

Widget formulario(BuildContext context) {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido =
      TextEditingController();

  TextEditingController correo = TextEditingController();
  TextEditingController telefono =
      TextEditingController();

  TextEditingController fechaNacimiento =
      TextEditingController(); 

  TextEditingController pais = TextEditingController();
  TextEditingController generoFavorito =
      TextEditingController(); 
      
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
>>>>>>> 1f7ba2be4e03e38d3160627ec9fc8b090bfc3b7c
}
 
class _FormularioRegistroState extends State<FormularioRegistro> {
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellido = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController telefono = TextEditingController();
  final TextEditingController fechaNacimiento = TextEditingController();
  final TextEditingController pais = TextEditingController();
  final TextEditingController generoFavorito = TextEditingController();
  final TextEditingController contrasenia = TextEditingController();
 
  XFile? _foto;
 
  void _actualizarImagen(XFile? nuevaImagen) {
    setState(() {
      _foto = nuevaImagen;
    });
  }
 
  void _mostrarOpcionesFoto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text(
                  'Galería',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  final imagen = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  _actualizarImagen(imagen);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.white),
                title: const Text(
                  'Cámara',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  final imagen = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  _actualizarImagen(imagen);
                },
              ),
            ],
          ),
        );
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: GestureDetector(
            onTap: () => _mostrarOpcionesFoto(context),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  backgroundImage: _foto != null
                      ? FileImage(File(_foto!.path))
                      : null,
                  child: _foto == null
                      ? const Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.white38,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _foto == null ? "Añadir foto de perfil" : "Cambiar foto",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 30),
 
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
            bool registroExitoso = await registro(
              context,
              nombre,
              apellido,
              correo,
              telefono,
              fechaNacimiento,
              pais,
              generoFavorito,
              contrasenia,
              _foto?.path,
            );
 
            if (registroExitoso) {
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
            }
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
          child: const Text("Registrarse"),
        ),
      ],
    );
  }
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
 
Future<bool> registro(
  BuildContext context,
  TextEditingController nombre,
  TextEditingController apellido,
  TextEditingController correo,
  TextEditingController telefono,
  TextEditingController fechaNacimiento,
  TextEditingController pais,
  TextEditingController generoFavorito,
  TextEditingController contrasenia,
  String? imagenRuta,
) async {
  try {
    print("Iniciando Auth SignUp en Supabase...");
    final AuthResponse res = await supabase.auth.signUp(
      email: correo.text.trim(),
      password: contrasenia.text.trim(),
    );
 
    final User? user = res.user;
 
    if (user == null) {
      print("Error: El usuario devuelto por Auth es NULL");
      return false;
    }
 
    print("Usuario creado en Auth con ID: ${user.id}");
    String? avatarUrl;
 
    if (imagenRuta != null) {
      print("Preparando archivo de imagen desde la ruta: $imagenRuta");
      final avatarFile = File(imagenRuta);
 
      if (!await avatarFile.exists()) {
        print(
          "ERROR CRÍTICO: El archivo de la imagen no existe en la ruta especificada.",
        );
      } else {
        final String fileName = '${user.id}_avatar.png';
 
        print("Subiendo imagen al Storage (Bucket: AVATARS)...");
 
        await supabase.storage
            .from('Avatars')
            .upload(
              fileName,
              avatarFile,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ),
            );
 
        avatarUrl = supabase.storage.from('Avatars').getPublicUrl(fileName);
        print("Imagen subida exitosamente. URL generada: $avatarUrl");
      }
    } else {
      print("No se seleccionó ninguna imagen (imagenRuta es NULL).");
    }
 
    print("Insertando datos en la tabla 'perfiles'...");
 
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(fechaNacimiento.text.trim());
    } catch (_) {
      parsedDate = DateTime.now();
      print("Advertencia: No se pudo parsear la fecha, usando fecha actual.");
    }
 
    await supabase.from('perfiles').insert({
      'id': user.id,
      'nombre': nombre.text.trim(),
      'apellido': apellido.text.trim(),
      'telefono': telefono.text.trim(),
      'fecha_nacimiento': parsedDate.toIso8601String(),
      'pais': pais.text.trim(),
      'genero_favorito': generoFavorito.text.trim(),
      'avatar_url': avatarUrl,
    });
 
    print("¡Registro completo en 'perfiles' finalizado con éxito!");
    return true;
  } catch (e) {
    print("ERROR CRÍTICO EN EL FLUJO DE REGISTRO: $e");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error en el Servidor"),
        content: Text(e.toString()),
      ),
    );
    return false;
  }
}
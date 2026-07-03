import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 
class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});
 
  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}
 
class _PantallaPerfilState extends State<PantallaPerfil> {
  final supabase = Supabase.instance.client;
 
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellido = TextEditingController();
  final TextEditingController telefono = TextEditingController();
  final TextEditingController fechaNacimiento = TextEditingController();
  final TextEditingController pais = TextEditingController();
  final TextEditingController generoFavorito = TextEditingController();
 
  XFile? _foto;
  String? _currentAvatarUrl;
 
  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }
 
  Future<void> _cargarDatosUsuario() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('perfiles')
        .select(
          'avatar_url, nombre, apellido, telefono, fecha_nacimiento, pais, genero_favorito',
        )
        .eq('id', userId)
        .maybeSingle();
 
    if (response != null && mounted) {
      setState(() {
        nombre.text = response['nombre'] ?? '';
        apellido.text = response['apellido'] ?? '';
        telefono.text = response['telefono'] ?? '';
        fechaNacimiento.text = response['fecha_nacimiento'] ?? '';
        pais.text = response['pais'] ?? '';
        generoFavorito.text = response['genero_favorito'] ?? '';
        _currentAvatarUrl = response['avatar_url'];
      });
    }
  }
 
  Future<void> _guardarCambios() async {
    final userId = supabase.auth.currentUser!.id;
    String? newAvatarUrl = _currentAvatarUrl;
 
    if (_foto != null) {
      final avatarFile = File(_foto!.path);
      final fileName = '${userId}_avatar.png';
      supabase.storage
          .from('avatars')
          .upload(
            fileName,
            avatarFile,
            fileOptions: const FileOptions(upsert: true),
          );
      newAvatarUrl = fileName;
    }
 
    await supabase
        .from('perfiles')
        .update({
          'nombre': nombre.text,
          'apellido': apellido.text,
          'telefono': telefono.text,
          'fecha_nacimiento': fechaNacimiento.text,
          'pais': pais.text,
          'genero_favorito': generoFavorito.text,
          'avatar_url': newAvatarUrl,
        })
        .eq('id', userId);
 
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Perfil actualizado")));
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _mostrarOpcionesFoto(context),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    backgroundImage: _foto != null
                        ? FileImage(File(_foto!.path))
                        : (_currentAvatarUrl != null &&
                                      _currentAvatarUrl!.isNotEmpty
                                  ? NetworkImage(
                                      supabase.storage
                                          .from('Avatars')
                                          .getPublicUrl('$_currentAvatarUrl'),
                                    )
                                  : null)
                              as ImageProvider?,
                    child:
                        (_foto == null &&
                            (_currentAvatarUrl == null ||
                                _currentAvatarUrl!.isEmpty))
                        ? const Icon(
                            Icons.person,
                            size: 55,
                            color: Colors.white38,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(nombre, "Nombre", Icons.person_outline),
              const SizedBox(height: 20),
              _buildTextField(apellido, "Apellido", Icons.person_outline),
              const SizedBox(height: 20),
              _buildTextField(telefono, "Teléfono", Icons.phone_outlined),
              const SizedBox(height: 20),
              _buildTextField(
                fechaNacimiento,
                "Fecha (AAAA-MM-DD)",
                Icons.calendar_today_outlined,
              ),
              const SizedBox(height: 20),
              _buildTextField(pais, "País", Icons.public),
              const SizedBox(height: 20),
              _buildTextField(
                generoFavorito,
                "Género favorito",
                Icons.movie_filter_outlined,
              ),
              const SizedBox(height: 40),
              FilledButton(
                onPressed: _guardarCambios,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                ),
                child: const Text("Guardar Cambios"),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
 
  Future<void> _mostrarOpcionesFoto(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galería'),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? imagen = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (imagen != null) {
                  setState(() => _foto = imagen);
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Cámara'),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? imagen = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (imagen != null) {
                  setState(() => _foto = imagen);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
 
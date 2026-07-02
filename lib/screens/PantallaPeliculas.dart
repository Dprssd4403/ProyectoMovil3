import 'dart:convert';
import 'package:app_taller1/screens/Home.dart';
import 'package:app_taller1/screens/PantallaInicioSesion.dart';
import 'package:app_taller1/screens/PantallaPerfil.dart';
import 'package:app_taller1/screens/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_taller1/main.dart';
 
class PantallaPeliculas extends StatefulWidget {
  const PantallaPeliculas({super.key});
 
  @override
  State<PantallaPeliculas> createState() => _PantallaPeliculasState();
}
 
class _PantallaPeliculasState extends State<PantallaPeliculas> {
  Future<List<dynamic>> _cargarPeliculasJson() async {
    final String respuesta = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/json/peliculas.json');
    return json.decode(respuesta);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Cartelera",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PantallaPerfil()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () async {
              await supabase.auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Welcome(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _cargarPeliculasJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error al cargar la cartelera",
                style: TextStyle(color: Colors.red.shade800),
              ),
            );
          }
 
          final List<dynamic> peliculas = snapshot.data ?? [];
 
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: peliculas.length,
            itemBuilder: (context, index) {
              final pelicula = peliculas[index];
 
              final String generosTexto = pelicula["generos"] != null
                  ? (pelicula["generos"] as List<dynamic>).join(", ")
                  : "";
 
              return GestureDetector(
                onTap: () =>
                    _mostrarModalDetalles(context, pelicula, generosTexto),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          pelicula["url_poster"] ?? "",
                          width: 95,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 95,
                                height: 140,
                                color: Colors.white10,
                                child: const Icon(
                                  Icons.movie,
                                  color: Colors.white30,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pelicula["titulo"] ?? "Sin título",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber.shade600,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${pelicula["calificacion"] ?? 0.0}  |  ",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${pelicula["anio"] ?? ''}  |  ${pelicula["duracion"] ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              generosTexto,
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pelicula["sinopsis"] ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: OutlinedButton.icon(
                                onPressed: () => _mostrarModalComentarios(
                                  context,
                                  pelicula["titulo"] ?? "",
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(color: Colors.red.shade800),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.comment_outlined,
                                  size: 16,
                                  color: Colors.white70,
                                ),
                                label: const Text(
                                  "Comentarios",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
 
  void _mostrarModalDetalles(
    BuildContext context,
    dynamic pelicula,
    String generos,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) =>
          ModalDetallesContenido(pelicula: pelicula, generos: generos),
    );
  }
 
  void _mostrarModalComentarios(BuildContext context, String peliculaTitulo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ModalComentariosContenido(peliculaTitulo: peliculaTitulo),
        );
      },
    );
  }
}
 
class ModalDetallesContenido extends StatelessWidget {
  final dynamic pelicula;
  final String generos;
 
  const ModalDetallesContenido({
    super.key,
    required this.pelicula,
    required this.generos,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                pelicula["url_poster"] ?? "",
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  width: 150,
                  color: Colors.white10,
                  child: const Icon(
                    Icons.movie,
                    color: Colors.white30,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            pelicula["titulo"] ?? "Sin título",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade600, size: 16),
              const SizedBox(width: 6),
              Text(
                "${pelicula["calificacion"] ?? 0.0}  •  ",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${pelicula["anio"] ?? ''}  •  ${pelicula["duracion"] ?? ''}",
                style: const TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            generos,
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Sinopsis",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            pelicula["sinopsis"] ?? "No hay sinopsis disponible.",
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
 
class ModalComentariosContenido extends StatefulWidget {
  final String peliculaTitulo;
  const ModalComentariosContenido({super.key, required this.peliculaTitulo});
 
  @override
  State<ModalComentariosContenido> createState() =>
      _ModalComentariosContenidoState();
}
 
class _ModalComentariosContenidoState extends State<ModalComentariosContenido> {
  final TextEditingController _comentarioController = TextEditingController();
  bool _cargando = false;
  String? _idComentarioEditando;
 
  String? _obtenerIdUsuarioSeguro() {
    final session = supabase.auth.currentSession;
    if (session != null && session.user.id.isNotEmpty) {
      return session.user.id.trim();
    }
    final user = supabase.auth.currentUser;
    if (user != null && user.id.isNotEmpty) {
      return user.id.trim();
    }
    return null;
  }
 
  Future<void> _guardarOEditarComentario() async {
    if (_comentarioController.text.trim().isEmpty) return;
 
    final String? uidActivo = _obtenerIdUsuarioSeguro();
 
    if (uidActivo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Error: No se detectó ninguna sesión activa de usuario.",
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
 
    setState(() => _cargando = true);
    try {
      String nombreUsuario = "Usuario";
 
      final perfilData = await supabase
          .from('perfiles')
          .select('nombre, apellido')
          .eq('id', uidActivo)
          .maybeSingle();
 
      if (perfilData != null) {
        nombreUsuario = "${perfilData['nombre']} ${perfilData['apellido']}";
      }
 
      final String comentarioTexto = _comentarioController.text.trim();
      final String comentarioFinal = "$nombreUsuario: $comentarioTexto";
 
      if (_idComentarioEditando == null) {
        await supabase.from('comentarios').insert({
          'pelicula_titulo': widget.peliculaTitulo,
          'comentario': comentarioFinal,
          'id_usuario': uidActivo,
        });
      } else {
        await supabase
            .from('comentarios')
            .update({'comentario': comentarioFinal})
            .eq('id', _idComentarioEditando!);
 
        _idComentarioEditando = null;
      }
 
      _comentarioController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }
 
  void _mostrarDialogoConfirmacion(BuildContext context, dynamic idComentario) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "¿Eliminar comentario?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            "Esta acción no se puede deshacer. ¿Estás seguro de que quieres borrar tu opinión?",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _eliminarComentario(idComentario);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Eliminar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
 
  Future<void> _eliminarComentario(dynamic idComentario) async {
    try {
      await supabase.from('comentarios').delete().eq('id', idComentario);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al eliminar: $e"),
          backgroundColor: Colors.red.shade900,
        ),
      );
    }
  }
 
  void _activarModoEdicion(dynamic idComentario, String textoComentario) {
    String mensajeLimpio = textoComentario;
    if (textoComentario.contains(': ')) {
      mensajeLimpio = textoComentario.substring(
        textoComentario.indexOf(': ') + 2,
      );
    }
    setState(() {
      _idComentarioEditando = idComentario.toString();
      _comentarioController.text = mensajeLimpio;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final String? uidSesionMismoWidget = _obtenerIdUsuarioSeguro();
 
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            _idComentarioEditando == null
                ? "Comentarios — ${widget.peliculaTitulo}"
                : "Modificando tu comentario...",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
 
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase
                  .from('comentarios')
                  .stream(primaryKey: ['id'])
                  .eq('pelicula_titulo', widget.peliculaTitulo)
                  .order('fecha_creacion', ascending: false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Aún no hay opiniones.",
                      style: TextStyle(color: Colors.white30, fontSize: 14),
                    ),
                  );
                }
 
                final comentarios = snapshot.data!;
 
                return ListView.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    final item = comentarios[index];
                    final String textoCompleto = item['comentario'] ?? '';
 
                    final String creadorId = (item['id_usuario'] ?? '')
                        .toString()
                        .trim()
                        .toLowerCase();
                    final String comparadorUidLocal =
                        (uidSesionMismoWidget ?? '')
                            .toString()
                            .trim()
                            .toLowerCase();
 
                    String autor = "Usuario";
                    String mensaje = textoCompleto;
 
                    if (textoCompleto.contains(': ')) {
                      int idx = textoCompleto.indexOf(': ');
                      autor = textoCompleto.substring(0, idx);
                      mensaje = textoCompleto.substring(idx + 2);
                    }
 
                    final bool esMiComentario =
                        comparadorUidLocal.isNotEmpty &&
                        creadorId == comparadorUidLocal;
 
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.02),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  autor,
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  mensaje,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (esMiComentario) ...[
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white38,
                                size: 18,
                              ),
                              onPressed: () => _activarModoEdicion(
                                item['id'],
                                textoCompleto,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                                size: 18,
                              ),
                              onPressed: () => _mostrarDialogoConfirmacion(
                                context,
                                item['id'],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(color: Colors.white10, height: 24),
 
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _comentarioController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: "Deja tu opinión sobre la película...",
                    hintStyle: const TextStyle(color: Colors.white24),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: _idComentarioEditando != null
                        ? IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white38,
                            ),
                            onPressed: () => setState(() {
                              _idComentarioEditando = null;
                              _comentarioController.clear();
                            }),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: _cargando
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        _idComentarioEditando == null
                            ? Icons.send_rounded
                            : Icons.check_circle_outline_rounded,
                        color: Colors.red.shade800,
                        size: 26,
                      ),
                onPressed: _cargando ? null : _guardarOEditarComentario,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
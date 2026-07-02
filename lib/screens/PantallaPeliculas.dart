import 'dart:convert';
import 'package:flutter/material.dart';

class PantallaPeliculas extends StatefulWidget {
  final Function(Map<String, dynamic>) onPeliculaSeleccionada;

  const PantallaPeliculas({super.key, required this.onPeliculaSeleccionada});

  @override
  State<PantallaPeliculas> createState() => _PantallaPeliculasState();
}

class _PantallaPeliculasState extends State<PantallaPeliculas> {
  Future<List<dynamic>> _cargarPeliculasJson() async {
    final String respuesta = await DefaultAssetBundle.of(context)
        .loadString('assets/json/peliculas.json');
    return json.decode(respuesta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Cartelera",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _cargarPeliculasJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error al cargar la cartelera", style: TextStyle(color: Colors.red.shade800)),
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
                onTap: () => _mostrarModalDetalles(context, pelicula, generosTexto),
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
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 95,
                            height: 140,
                            color: Colors.white10,
                            child: const Icon(Icons.movie, color: Colors.white30),
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
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber.shade600, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  "${pelicula["calificacion"] ?? 0.0}  |  ",
                                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${pelicula["anio"] ?? ''}  |  ${pelicula["duracion"] ?? ''}",
                                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              generosTexto,
                              style: TextStyle(color: Colors.red.shade800, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pelicula["sinopsis"] ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.3),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: OutlinedButton.icon(
                                onPressed: () => _mostrarModalComentarios(context, pelicula["titulo"] ?? ""),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(color: Colors.red.shade800),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                ),
                                icon: const Icon(Icons.comment_outlined, size: 16, color: Colors.white70),
                                label: const Text("Comentarios", style: TextStyle(fontSize: 12)),
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

  void _mostrarModalDetalles(BuildContext context, dynamic pelicula, String generos) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => ModalDetallesContenido(
        pelicula: pelicula, 
        generos: generos,
        onPlayPressed: widget.onPeliculaSeleccionada,
      ),
    );
  }

  void _mostrarModalComentarios(BuildContext context, String peliculaTitulo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Text("Comentarios de $peliculaTitulo", style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }
}

class ModalDetallesContenido extends StatelessWidget {
  final dynamic pelicula;
  final String generos;
  final Function(Map<String, dynamic>) onPlayPressed;

  const ModalDetallesContenido({
    super.key, 
    required this.pelicula, 
    required this.generos,
    required this.onPlayPressed,
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
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
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
                  child: const Icon(Icons.movie, color: Colors.white30, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            pelicula["titulo"] ?? "Sin título",
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Director: ${pelicula["director"] ?? 'Desconocido'}",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            generos,
            style: TextStyle(color: Colors.red.shade800, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            pelicula["sinopsis"] ?? "",
            style: const TextStyle(color: Colors.white60, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context);
                onPlayPressed(Map<String, dynamic>.from(pelicula));
              },
              icon: const Icon(Icons.play_arrow_rounded, size: 28),
              label: const Text(
                "Reproducir Película",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
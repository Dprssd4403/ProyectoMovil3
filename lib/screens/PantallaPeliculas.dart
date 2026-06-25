import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Asegúrate de tener la instancia de Supabase accesible

class Pantallapeliculas extends StatelessWidget {
  const Pantallapeliculas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Cartelera",
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            letterSpacing: 1.2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Películas Disponibles",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: listaPeliculas(context),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> leerJsonLocal(BuildContext context) async {
  final String respuesta = await DefaultAssetBundle.of(
    context,
  ).loadString('assets/json/peliculas.json');
  final data = jsonDecode(respuesta);
  return data;
}

Widget listaPeliculas(BuildContext context) {
  return FutureBuilder<List<dynamic>>(
    future: leerJsonLocal(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator(color: Colors.red));
      }
      if (snapshot.hasError) {
        return Center(
          child: Text(
            "Error al cargar películas: ${snapshot.error}",
            style: const TextStyle(color: Colors.white54),
          ),
        );
      }
      if (snapshot.hasData) {
        final listaPeliculas = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: listaPeliculas.length,
          itemBuilder: (context, index) {
            final pelicula = listaPeliculas[index];
            
            // Controlador local para capturar el texto de este TextField específico
            final TextEditingController comentarioController = TextEditingController();

            return Card(
              color: Colors.white.withOpacity(0.04),
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.white.withOpacity(0.05)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          pelicula['url_poster'],
                          width: 55,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 55,
                            height: 80,
                            color: Colors.white10,
                            child: const Icon(Icons.movie, color: Colors.white38),
                          ),
                        ),
                      ),
                      title: Text(
                        pelicula['titulo'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${pelicula['director']} • ${pelicula['anio']}",
                          style: const TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              pelicula['calificacion'].toString(),
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        print("Clic en: ${pelicula['titulo']}");
                      },
                    ),
                    
                    // MODIFICADO: TextField con botón para enviar a Supabase
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: comentarioController,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.03),
                                hintText: "Escribe un comentario...",
                                hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                                prefixIcon: const Icon(Icons.comment_outlined, color: Colors.white38, size: 18),
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.red, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.red),
                            onPressed: () {
                              if (comentarioController.text.trim().isNotEmpty) {
                                // Llamamos a la función para guardar en Supabase
                                guardarComentario(
                                  context, 
                                  pelicula['titulo'], // O usa pelicula['id'] si tu JSON local tiene IDs
                                  comentarioController.text.trim()
                                );
                                comentarioController.clear(); // Limpia el campo tras enviar
                              }
                            },
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
      } else {
        return const Center(child: CircularProgressIndicator(color: Colors.red));
      }
    },
  );
}

// NUEVA FUNCIÓN: Envía los datos directamente a tu tabla de Supabase
Future<void> guardarComentario(BuildContext context, String tituloPelicula, String comentario) async {
  try {
    final supabase = Supabase.instance.client;

    await supabase.from('comentarios').insert({
      'pelicula_titulo': tituloPelicula,
      'comentario': comentario,
      'fecha_creacion': DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Comentario guardado con éxito"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text("Error al guardar", style: TextStyle(color: Colors.white)),
        content: Text(error.toString(), style: const TextStyle(color: Colors.white70)),
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
import 'package:app_taller1/screens/PantallaPeliculas.dart';
import 'package:app_taller1/screens/PantallaReproductor.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indice = 0;

  Map<String, dynamic> peliculaActual = {};

  void reproducirPelicula(Map<String, dynamic> pelicula) {
    setState(() {
      peliculaActual = pelicula;
      indice = 1;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> paginas = [
      PantallaPeliculas(
        onPeliculaSeleccionada: reproducirPelicula,
      ),
      PantallaReproductor(
        key: ValueKey(peliculaActual['id'] ?? 'vacio'),
        pelicula: peliculaActual,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: IndexedStack(index: indice, children: paginas),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: (value) => setState(() {
          indice = value;
        }),
        selectedItemColor: Colors.red.shade800,
        unselectedItemColor: Colors.white54,
        backgroundColor: const Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: "Cartelera",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            activeIcon: Icon(Icons.play_circle_filled),
            label: "Reproductor",
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PantallaReproductor extends StatefulWidget {
  final Map<String, dynamic> pelicula;

  const PantallaReproductor({
    super.key,
    required this.pelicula,
  });

  @override
  State<PantallaReproductor> createState() => _PantallaReproductorState();
}

class _PantallaReproductorState extends State<PantallaReproductor> {
  YoutubePlayerController? _controller;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();

    final String urlVideo = widget.pelicula['url_video'] ?? '';
    final String? videoId = YoutubePlayer.convertUrlToId(urlVideo);

    if (videoId == null) {
      // El link no es un link de YouTube válido (ej. sigue siendo un link de Drive)
      setState(() {
        _errorMsg = 'El link de este video no es un enlace válido de YouTube.';
      });
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.pelicula['titulo'] ?? 'Reproductor'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: _errorMsg != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMsg!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              )
            : _controller == null
                ? const CircularProgressIndicator(color: Colors.red)
                : YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                      onReady: () {
                        debugPrint('▶️ Reproductor de YouTube listo');
                      },
                    ),
                    builder: (context, player) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            player,
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                widget.pelicula['sinopsis'] ?? '',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
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
    final String? videoId = YoutubePlayerController.convertUrlToId(urlVideo);

    if (videoId == null) {
      setState(() {
        _errorMsg = 'Seleccione una pelicula para visualizar';
      });
      return;
    }

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.close();
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
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: _controller!,
                          aspectRatio: 16 / 9,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            widget.pelicula['sinopsis'] ?? '',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
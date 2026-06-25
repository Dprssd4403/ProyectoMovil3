import 'package:flutter/material.dart';

class PantallaReproductor extends StatelessWidget {

  const PantallaReproductor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.grey.shade900,
                child: const Center(
                  child: Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.white12,
                    size: 80,
                  ),
                ),
              ),
              Container(
                color: Colors.black38,
              ),
              const IconButton(
                icon: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 64,
                ),
                onPressed: null,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: SliderComponentShape.noThumb,
                        trackHeight: 4,
                        overlayShape: SliderComponentShape.noOverlay,
                      ),
                      child: Slider(
                        value: 0.3,
                        onChanged: null,
                        activeColor: Colors.red.shade800,
                        inactiveColor: Colors.white12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "01:24",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          "02:15",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
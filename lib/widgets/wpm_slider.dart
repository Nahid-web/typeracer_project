import 'package:flutter/material.dart';
import 'package:typeracer_project/provider/game_state_provider.dart';

class WpmSlider extends StatelessWidget {
  final GameStateProvider game;

  const WpmSlider({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: game.gameState['players'].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(
                    game.gameState['players'][index]['nickname'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Slider(
                  value: (game.gameState['players'][index]['currentWordIndex'] /
                      game.gameState['words'].length),
                  onChanged: (val) {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

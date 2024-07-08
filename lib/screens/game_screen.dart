import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_project/provider/client_state_provider.dart';
import 'package:typeracer_project/provider/game_state_provider.dart';
import 'package:typeracer_project/utils/socket_methods.dart';
import 'package:typeracer_project/widgets/game_text_field.dart';
import 'package:typeracer_project/widgets/sentence_game.dart';
import 'package:typeracer_project/widgets/wpm_slider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateTimer(context);
    _socketMethods.updateGame(context);
    _socketMethods.gameFinishedListener();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    final clientStateProvider = Provider.of<ClientStateProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Chip(
                label: Text(
                  clientStateProvider.clientState['timer']['msg'].toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                clientStateProvider.clientState['timer']['countDown']
                    .toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SentenceGame(),
              WpmSlider(game: game),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: game.gameState['id']))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Game code copied to click"),
                        ),
                      );
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    fillColor: const Color(0xffF5F5FA),
                    hintText: 'Click to Copy Game Code',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GameTextField(),
    );
  }
}

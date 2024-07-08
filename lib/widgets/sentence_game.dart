import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_project/utils/socket_methods.dart';
import 'package:typeracer_project/widgets/scoreboard.dart';

import '../provider/game_state_provider.dart';
import '../utils/socket_client.dart';

class SentenceGame extends StatefulWidget {
  const SentenceGame({super.key});

  @override
  State<SentenceGame> createState() => _SentenceGameState();
}

class _SentenceGameState extends State<SentenceGame> {
  var playerMe;
  final SocketMethods _socketMethods = SocketMethods();

  findPlayerMe(GameStateProvider game) {
    game.gameState['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
      }
    });
  }

  Widget getTypedWords(words, player) {
    var tempWords = words.sublist(0, player['currentWordIndex']);
    String typeWord = tempWords.join(' ');

    return Text(
      typeWord,
      style: const TextStyle(
        color: Color.fromRGBO(52, 235, 119, 1),
        fontSize: 30,
      ),
    );
  }

  Widget getCurrentWords(words, player) {
    return Text(
      words[player['currentWordIndex']],
      style: const TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 30,
      ),
    );
  }

  Widget getWordsToBeTyped(words, player) {
    var tempWords = words.sublist(player['currentWordIndex'] + 1, words.length);
    String wordsToBeTyped = tempWords.join(' ');

    return Text(
      wordsToBeTyped,
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGame(context);
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    findPlayerMe(game);

    if (game.gameState['words'].length > playerMe['currentWordIndex']) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          textDirection: TextDirection.ltr,
          children: [
            getTypedWords(game.gameState['words'], playerMe),
            getCurrentWords(game.gameState['words'], playerMe),
            getWordsToBeTyped(game.gameState['words'], playerMe),
          ],
        ),
      );
    }
    return const Scoreboard();
  }
}

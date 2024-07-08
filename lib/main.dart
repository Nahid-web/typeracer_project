import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer_project/provider/client_state_provider.dart';
import 'package:typeracer_project/provider/game_state_provider.dart';
import 'package:typeracer_project/screens/create_room_screen.dart';
import 'package:typeracer_project/screens/game_screen.dart';
import 'package:typeracer_project/screens/home_screen.dart';
import 'package:typeracer_project/screens/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientStateProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Typeracer Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: false,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/create-room': (context) => const CreateRoomScreen(),
          '/join-room': (context) => const JoinRoomScreen(),
          '/game-screen': (context) => const GameScreen(),
        },
      ),
    );
  }
}

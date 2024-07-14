import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/domain/navigation/navigation.dart';
import '../../../application/home_page/home_bloc.dart';
import 'bubble_background.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Navigation
    void screenNavigation(String route){
      Navigator.pushNamed(context, route);
    }

    return Stack(children: [
      AnimatedBubbleBackground(size: size),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Score Keeper',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 64),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: _buildButton(Icons.add, 'New Game', () {
                    screenNavigation(NavigationRoute.createTournamentScreen);
                  }),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: _buildButton(Icons.play_arrow, 'Resume', () {
                    screenNavigation(NavigationRoute.tournamentsScreen);
                  }),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: _buildButton(Icons.leaderboard, 'Scoreboard', () {

                    // Handle Scoreboard button press
                  }),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: _buildButton(Icons.book, 'Rules', () {
                    // Handle Rules button press
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  Widget _buildButton(IconData icon, String text, Function() onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }
}

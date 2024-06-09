import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../domain/entities/player_entity.dart';
import 'add_player_widget.dart';

class CreateTournamentPage extends StatelessWidget {

  List<Player> players  = [
    Player(id: 1, name: "Igor"),
    Player(id: 2, name: "Hanna"),
  ];

  CreateTournamentPage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _playerNameController = TextEditingController();
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Tournament", style: themeData.textTheme.headlineLarge),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: themeData.appBarTheme.foregroundColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text("Title", style: themeData.textTheme.bodySmall),
          ),
          SizedBox(
          width: size.width,
          child: TextField(
            style:  themeData.textTheme.bodyMedium,
            controller: _titleController,
            maxLength: 25,
            decoration: const InputDecoration(
              hintText: 'Enter Title for you Tournament',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              )
            ),
          ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("Add player", style: themeData.textTheme.bodySmall),
            ),
            SizedBox(
              width: size.width,
              child: TextField(
                style:  themeData.textTheme.bodyMedium,
                controller: _playerNameController,
                maxLength: 25,
                decoration: InputDecoration(
                    hintText: 'Enter player name',
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // Handle the tap on the icon here
                          players.add(Player(id: players.last.id+1, name: _playerNameController.text)); //TODO
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Player ${_playerNameController.text} added', )),
                        );
                      },
                      child: const Icon(Icons.add_circle, color: Colors.green,),
                    ), // Add the icon here
                ),
              ),
            ),
            SizedBox(
              height: 60*players.length.toDouble(),
              width: size.width,
              child:  AddPlayerWidget(players: players),
            )


          ],
        ),
      ),
    );
  }
}

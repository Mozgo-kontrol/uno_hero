import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../../domain/entities/player_entity.dart';
import 'add_player_card_widget.dart';


class CreateTournamentPage extends StatefulWidget {


  const CreateTournamentPage({super.key});
  @override
  State<CreateTournamentPage> createState() => _CreateTournamentPageState();
}

class _CreateTournamentPageState extends State<CreateTournamentPage> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController playerNameController = TextEditingController();





  int id = 1;
  List<Player> players = [];

  void removePlayer(int id){
    setState(() {
      players.removeAt(id);
    });
  }

  void addPlayer(){
    setState(() {
      if(playerNameController.text.isNotEmpty) {
        int id = players.isEmpty ? 1 : players.last.id + 1;
        players.add(Player(id: id, name: playerNameController.text));
        playerNameController.clear();
        String message = 'Player ${playerNameController.text} added';
        showSnackBar(message);
      }
      else{
        showSnackBar("add player name");
      }
    });
  }

  void showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text("Title", style: themeData.textTheme.headlineMedium),
            ),
            SizedBox(
              width: size.width,
              child: TextField(
                style:  themeData.textTheme.bodyMedium,
                controller: titleController,
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
              child: Text("Add player", style: themeData.textTheme.headlineMedium),
            ),
            SizedBox(
              width: size.width,
              child: TextField(
                style:  themeData.textTheme.bodyMedium,
                controller: playerNameController,
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
                      addPlayer();
                    },
                    child: const Icon(Icons.add_circle, color: Colors.green,size: 35,),
                  ), // Add the icon here
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Card(

                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: players.length,
                  itemBuilder: (BuildContext context, int index) {
                    final player = players[index]; // Store the player for readability
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(player.name),
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return true;
                        }
                      },
                      child: AddPlayerCardWidget(
                        id: player.id,
                        name: player.name,
                        onPressed: () => {
                          // Handle player selection here, e.g., navigate to a details screen
                          print('Selected player: ${player.name}')
                        },
                      ),
                      onDismissed: (_) {
                        removePlayer(index);
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: () => {}, style: TextButton.styleFrom(
              foregroundColor: Colors.redAccent,), child: const Text("Cancel")),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                    ),
                    onPressed: () {Navigator.pushNamed(context, '/scopes_screen', arguments: id);},
                    child: const Text("Start"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



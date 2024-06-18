
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/create_tournament_page/widgets/pop_up_dialog.dart';
import '../../../application/create_tournament_page/create_tournamet_bloc.dart';
import 'error_message_widget.dart';
import '../../../application/tournament_page/tournament_bloc.dart';
import '../scope_screen_arguments.dart';
import 'add_player_card_widget.dart';


// 1. Rename the class to be more descriptive.
class TournamentCreationPage extends StatelessWidget {
  const TournamentCreationPage({super.key});
  void _showTopPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Align(
          alignment: Alignment.topCenter, // Position the popup at the top
          child: TopPopupDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    final titleController = TextEditingController();
    final playerNameController = TextEditingController();
    bool isTitleEmpty = false;


    // 2. Extract the BlocProvider to a separate variable for better readability.
    final createTournamentBloc = BlocProvider.of<CreateTournamentBloc>(context);

    void sendNewEvent(CreateTournamentEvent newEvent) {
      createTournamentBloc.add(newEvent);
    }

    return BlocBuilder<CreateTournamentBloc, CreateTournamentState>(
        bloc: createTournamentBloc..add(CreateTournamentInitEvent()),
        builder: (context, state) {
          if (state is CreateTournamentError) {
           // ScaffoldMessenger.of(context).showSnackBar(
           //   SnackBar(content: Text(state.message)),
           // );
            return ErrorMessage(message: state.message);

          } else if (state is CreateTournamentData) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text("New Tournament",
                    style: themeData.textTheme.headlineLarge),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: themeData.appBarTheme.foregroundColor),
                  onPressed: () => Navigator.pop(context, (){
                    context.read<TournamentBloc>().add(RefreshTournamentsEvent());
                  })
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Use a more descriptive widget name for the title section.
                    _buildTitleInput(themeData, titleController, size, sendNewEvent),
                    // 4. Use a more descriptive widget name for the player addition section.
                    _buildAddPlayerInput(
                        themeData, playerNameController, size, sendNewEvent),
                    // 5. Use a more descriptive widget name for the player list section.
                    _buildPlayerList(state, sendNewEvent),
                    // 6. Use a more descriptive widget name for the action buttons section.
                    _buildActionButtons(context, state, sendNewEvent),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  // 7. Extract the title input section into a separate widget for better organization.
  Widget _buildTitleInput(ThemeData themeData,
      TextEditingController titleController, Size size, Function(UpdateTitleEvent) sendNewEvent) {
    // Boolean variable to check for errors
    bool isTextTitleError = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("Title*", style: themeData.textTheme.headlineMedium),
        ), 
        SizedBox(
          width: size.width,
          child: TextField(
            style: themeData.textTheme.bodyMedium,
            controller: titleController,
            keyboardType: TextInputType.text,
            onChanged: sendNewEvent(UpdateTitleEvent(titleController.value.text)),
            autofocus: false,
            maxLength: 25,
            decoration: InputDecoration(
              hintText: 'Enter Title for your Tournament',
              errorText: isTextTitleError
             ? "Title field cannot be left empty" // Error message
             : null,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPlayerInput(ThemeData themeData,
      TextEditingController playerNameController, Size size,
      Function(CreateTournamentEvent) sendNewEvent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("Add Player*", style: themeData.textTheme.headlineMedium),
        ),
        SizedBox(
          width: size.width,
          child: TextField(
            style: themeData.textTheme.bodyMedium,
            controller: playerNameController,
            autofocus: false,
            keyboardType: TextInputType.text,
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
                  if(playerNameController.text.trim().isNotEmpty) {
                    sendNewEvent(AddPlayerEvent(playerNameController.text));
                    playerNameController.clear();
                  }
                },
                child: Icon(
                    Icons.add_circle, color: playerNameController.text.trim().isNotEmpty? Colors.green:Colors.grey , size: 35),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerList(CreateTournamentData state,
      Function(CreateTournamentEvent) sendNewEvent) {
    return Expanded(
      flex: 3,
      child: Card(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: state.players.length,
          itemBuilder: (BuildContext context, int index) {
            final player = state.players[index];
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
                return null;
              },
              child: AddPlayerCardWidget( // Assuming you have a custom widget for displaying player cards
                id: player.id,
                name: player.name,
                onPressed: () {
                  // Handle player selection (e.g., navigation)
                  print('Selected player: ${player.name}');
                },
              ),
              onDismissed: (_) {
                sendNewEvent(RemovePlayerEvent(player.id));
              },
            );
          },
        ),
      ),
    );
  }
  Widget _buildActionButtons(BuildContext context, CreateTournamentData state,
  Function(CreateTournamentEvent) sendNewEvent) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Handle cancel (e.g., pop the screen)
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              elevation: 0,
            ),
            onPressed: () {
              // Handle start tournament (e.g., navigate to the next screen)
              if(state.title.isNotEmpty&&state.players.isNotEmpty){
                sendNewEvent(StartTournamentEvent());
                Navigator.popAndPushNamed(context, '/scopes_screen',
                    arguments: ScopeScreenArguments(tournamentId: state.tournamentId));
              }
              else{
                _showTopPopup(context);
              }
            },

            child: const Text("Start"),
          ),
        ],
      ),
    );
  }
}
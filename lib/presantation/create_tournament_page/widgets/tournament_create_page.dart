import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/create_tournament_page/widgets/player_icon.dart';
import 'package:uno_notes/presantation/create_tournament_page/widgets/radio_group_widget.dart';
import '../../../application/common_widgets/pop_up_dialog.dart';
import '../../../application/create_tournament_page/Error.dart';
import '../../../application/create_tournament_page/create_tournamet_bloc.dart';
import '../../../application/services/app_localizations.dart';
import '../../../application/utils/utils.dart';
import 'error_message_widget.dart';
import '../../../application/tournament_page/tournament_bloc.dart';
import '../scope_screen_arguments.dart';
import 'grid_list.dart';

class TournamentCreationPage extends StatefulWidget {
  const TournamentCreationPage({super.key});

  @override
  State<TournamentCreationPage> createState() => _TournamentCreationPageState();
}

class _TournamentCreationPageState extends State<TournamentCreationPage> {
  final _titleController = TextEditingController();
  final _playerNameController = TextEditingController();
  final _playerNameFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  late final createTournamentBloc;
  late int currentIconId;
  late int countOfIcons;
  late int _selectedValue;

  @override
  void dispose() {
    _titleController.dispose();
    _playerNameController.dispose();
    _playerNameFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    createTournamentBloc = BlocProvider.of<CreateTournamentBloc>(context);
    createTournamentBloc.add(CreateTournamentInitEvent());
    currentIconId = Utils.iconsList.keys.first;
    countOfIcons = Utils.iconsList.length;
    _selectedValue = 0;
    print("init currentIcon with : $currentIconId");
    super.initState();
  }

  void _showTopPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.fromContext(context);
        return Align(
            alignment: Alignment.topCenter, // Position the popup at the top
            child: TopPopupDialog(
              errorType: localizations?.get("alert_warning") ?? 'Alert',
              message: localizations?.get('alert_min_player_count') ??
                  "You need at least two players to start the game!",
              onAgree: () {
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ));
      },
    );
  }

  void showRemovePlayerPopup(
      BuildContext context, String playerName, int playerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // final localizations = AppLocalizations.fromContext(context);
        return Align(
            alignment: Alignment.topCenter, // Position the popup at the top
            child: TopPopupDialog(
              errorType: 'Alert',
              message:
                  "Do you want remove player: ${playerName.toUpperCase()}?",
              onAgree: () {
                sendNewEvent(RemovePlayerEvent(playerId));
                Navigator.pop(context);
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ));
      },
    );
  }

  void _addPlayerPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final themeData = Theme.of(context);
          final localizations = AppLocalizations.fromContext(context);
          final size = MediaQuery.of(context).size;
          return StatefulBuilder(builder: (context, setState) {
            void setIcon() {
              setState(() {
                currentIconId = Utils.getNextIconId(currentIconId);
              });
            }

            return Align(
              alignment: Alignment.center, // Position the popup at the top
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.6,
                child: Card(
                  child: _buildAddPlayerInput(
                      localizations,
                      themeData,
                      _playerNameController,
                      _playerNameFocusNode,
                      sendNewEvent,
                      currentIconId,
                      setIcon),
                ),
              ),
            );
          });
        });
  }

  void sendNewEvent(CreateTournamentEvent newEvent) {
    setState(() {
      createTournamentBloc.add(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    final localizations = AppLocalizations.fromContext(context);
    return BlocBuilder<CreateTournamentBloc, CreateTournamentState>(
        bloc: createTournamentBloc,
        builder: (context, state) {
          if (state is CreateTournamentError) {
            return ErrorMessage(message: state.message);
          } else if (state is CreateTournamentData) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text(localizations?.get("new_game") ?? "New game",
                    style: themeData.textTheme.displayLarge),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.cyanAccent, Colors.lightBlueAccent, Colors.lightBlue], //Customize the colors as needed
                    ),
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => Navigator.pop(context, () {
                          context
                              .read<TournamentBloc>()
                              .add(RefreshTournamentsEvent());
                        })),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Use a more descriptive widget name for the title section.
                    _buildTitleInput(
                        localizations,
                        themeData,
                        state,
                        _titleController,
                        _titleFocusNode,
                        _playerNameFocusNode,
                        size,
                        sendNewEvent),
                   // RadioGroupWidget(selectedValue: _selectedValue, onChanged: (value) {setState(() {_selectedValue = value;});},),
                    // 5. Use a more descriptive widget name for the player list section.
                    _buildPlayerList(state, sendNewEvent),
                    // 6. Use a more descriptive widget name for the action buttons section.
                    _buildActionButtons(
                        localizations, context, state, sendNewEvent),
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
  Widget _buildTitleInput(
      AppLocalizations? localizations,
      ThemeData themeData,
      CreateTournamentData state,
      TextEditingController titleController,
      FocusNode thisFocusNode,
      FocusNode nextFocusNode,
      Size size,
      Function(UpdateTitleEvent) sendNewEvent) {
    // Boolean variable to check for errors
    bool isTextTitleEmpty = state.errors.isNotEmpty &&
        state.errors.contains(CustomInputError.titleEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(localizations?.get("title_c_g") ?? "Title*",
              style: themeData.textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: size.width,
            child: TextField(
              style: themeData.textTheme.bodyMedium,
              controller: titleController,
              focusNode: thisFocusNode,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                isTextTitleEmpty = value.trim().isEmpty;
                sendNewEvent(UpdateTitleEvent(value));
              },
              onSubmitted: (value) {
                nextFocusNode.requestFocus();
              },
              onTap: () {
                thisFocusNode.requestFocus();
              },
              autofocus: false,
              maxLength: 16,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText:
                    localizations?.get("hint_add_title_c_g") ?? 'Add title',
                errorText: isTextTitleEmpty
                    ? localizations?.get("error_text_title_c_g") ??
                        "Title field cannot be empty" // Error message
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
        ),
      ],
    );
  }

  Widget _buildAddPlayerInput(
      AppLocalizations? localizations,
      ThemeData themeData,
      TextEditingController playerNameController,
      FocusNode playerNameFocusNode, // Renamed for clarity
      Function(CreateTournamentEvent) addNewPlayer,
      int currentIconId,
      VoidCallback nextIconId) {
    print("currentIcon changed: $currentIconId");
    // Renamed for clarity
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                print("tap to change Icon");
                nextIconId();
              });
            },
            child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: playerNameController,
                builder: (context, value, child) {
                  return PlayerIcon(
                    iconIndex: currentIconId,
                    iconHeight: 110,
                    iconWidth: 110,
                  );
                }),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 180, // Increased width for better usability
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: themeData.textTheme.bodyLarge,
              controller: playerNameController,
              autofocus: false,
              focusNode: playerNameFocusNode,
              cursorColor: themeData.primaryColor,
              // Use theme color for consistency
              maxLength: 10,
              onSubmitted: (playerName) {
                if (playerNameController.text.trim().isNotEmpty) {
                  sendNewEvent(AddPlayerEvent(playerNameController.text,
                      currentIconId)); // Send event with player name
                  playerNameController.clear(); // Clear the text field
                  playerNameFocusNode.unfocus();
                  Navigator.pop(context);
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 1.0),
                // Adjustvertical padding
                constraints: const BoxConstraints(maxHeight: 48.0),
                counterText: '',
                hintText:
                    localizations?.get("hint_add_player_c_g") ?? "Enter name",
                hintStyle: themeData.textTheme.labelMedium,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, width: 2.0), // Use theme color
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, width: 2.0), // Use theme color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerList(CreateTournamentData state,
      Function(CreateTournamentEvent) sendNewEvent) {
    return Expanded(
      flex: 3,
      child: GridCustomPlayerList(
        players: state.players,
        onPressed: () {
          _addPlayerPopup(context);
        },
        onCardTap: (int playerId, String name) {
          showRemovePlayerPopup(context, name, playerId);
        },
      ),
    );
  }

  Widget _buildActionButtons(
      AppLocalizations? localizations,
      BuildContext context,
      CreateTournamentData state,
      Function(CreateTournamentEvent) sendNewEvent) {
    final themeData = Theme.of(context);
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            // Handle cancel (e.g., pop the screen)
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: Text(
              localizations?.get("cancel_bnt_c_g") ?? "Cancel",
              style: themeData.textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (state.isReadyToStart) {
                sendNewEvent(StartTournamentEvent());
                Navigator.popAndPushNamed(context, '/scopes_screen',
                    arguments:
                        ScopeScreenArguments(tournamentId: state.tournamentId));
              } else {
                _showTopPopup(context);
              }
            },
            child: Text(
              localizations?.get("start_bnt_c_g") ?? "Start",
              style:
                  themeData.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

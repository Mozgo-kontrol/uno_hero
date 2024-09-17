import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/create_game_screen/widgets/page_indicator.dart';

import '../../application/common_widgets/pop_up_dialog.dart';
import '../../application/create_tournament_page/Error.dart';
import '../../application/create_tournament_page/create_tournamet_bloc.dart';
import '../../application/services/app_localizations.dart';
import '../../application/utils/utils.dart';
import '../create_tournament_page/scope_screen_arguments.dart';
import '../create_tournament_page/widgets/error_message_widget.dart';
import '../create_tournament_page/widgets/grid_list.dart';
import '../create_tournament_page/widgets/player_icon.dart';

class CreateGameScreen extends StatefulWidget {
  const CreateGameScreen({super.key});

  @override
  State<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen>
    with TickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _playerNameController = TextEditingController();
  final _playerNameFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  late final createTournamentBloc;
  late int currentIconId;
  late int countOfIcons;

  late final PageController _pageViewController = PageController();
  late final CreateTournamentBloc _createTournamentBloc;
  late TabController _tabController;
  var _currentPageIndex = 0;

  @override
  void initState() {
    _createTournamentBloc = BlocProvider.of<CreateTournamentBloc>(context);
    _createTournamentBloc.add(CreateTournamentInitEvent());
    _tabController = TabController(length: 2, vsync: this);
    currentIconId = Utils.iconsList.keys.first;
    countOfIcons = Utils.iconsList.length;
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    _titleController.dispose();
    _playerNameController.dispose();
    _playerNameFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPageIndex = index;
    });
  }

  void showRemovePlayerPopup(BuildContext context, String playerName,
      int playerId) {
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
                _handleEvent(RemovePlayerEvent(playerId));
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
          final size = MediaQuery
              .of(context)
              .size;
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
                      _handleEvent,
                      currentIconId,
                      setIcon),
                ),
              ),
            );
          });
        });
  }


  void _showTopPopup(BuildContext context, AppLocalizations? localizations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

  void _handleEvent(CreateTournamentEvent event) {
    switch (event) {
      case NavigateToPreviousPageEvent():
        if (_currentPageIndex > 0) {
          _updateCurrentPageIndex(_currentPageIndex - 1);
        }
        break;
      case NavigateToNextPageEvent():
        if (_currentPageIndex == 0) {
          _updateCurrentPageIndex(_currentPageIndex + 1);
        }
        break;
      default:
        _createTournamentBloc.add(event);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    final localizations = AppLocalizations.fromContext(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text( (_currentPageIndex == 0)? localizations?.get("new_game") ?? "New game": "Players",
              style: themeData.textTheme.displayLarge)),
      body: BlocBuilder<CreateTournamentBloc, CreateTournamentState>(
          bloc: _createTournamentBloc,
          builder: (context, state) {
            if (state is CreateTournamentError) {
              return ErrorMessage(message: state.message);
            } else if (state is CreateTournamentData) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PageView(
                        onPageChanged: _updateCurrentPageIndex,
                        controller: _pageViewController,
                        children: [
                          _buildPart1(
                            localizations,
                            themeData,
                            state,
                            _titleController,
                            _titleFocusNode,
                            _playerNameFocusNode,
                            size,
                            _handleEvent
                          ),
                          _buildPart2(state, _handleEvent),
                        ],
                      ),
                    ),
                    _buildActionButtons(
                      localizations,
                      context,
                      _currentPageIndex,
                      state,
                      _handleEvent,
                    ),
                  ],
                ),
              );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _buildActionButtons(AppLocalizations? localizations,
      BuildContext context,
      int currentPageIndex,
      CreateTournamentData state,
      Function(CreateTournamentEvent) sendNewEvent) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Center(
          child: PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () =>
                {
                  if (_currentPageIndex == 0)
                    {Navigator.of(context).pop()}
                  else
                    {sendNewEvent(NavigateToPreviousPageEvent())}
                },
                style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                child: Text(
                  (currentPageIndex > 0)
                      ? "Back"
                      : localizations?.get("cancel_bnt_c_g") ?? "Cancel",
                  style: themeData.textTheme.bodyMedium,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_currentPageIndex == 0) {
                    sendNewEvent(NavigateToNextPageEvent());
                  } else {
                    if (state.isReadyToStart) {
                      sendNewEvent(StartTournamentEvent());
                      Navigator.popAndPushNamed(context, '/scopes_screen',
                          arguments:
                          ScopeScreenArguments(tournamentId: state.tournamentId));
                    } else {
                      _showTopPopup(context, localizations);
                    }
                  }
                },
                child: Text(
                  (currentPageIndex > 0)
                      ? localizations?.get("start_bnt_c_g") ?? "Start"
                      : "Continue",
                  style:
                  themeData.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // First Part
  Widget _buildPart1(
      AppLocalizations? localizations,
      ThemeData themeData,
      CreateTournamentData state,
      TextEditingController titleController,
      FocusNode titleFocusNode,
      FocusNode nextFocusNode,
      Size size,
      Function(CreateTournamentEvent) sendNewEvent

      ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleInput(
            localizations,
            themeData,
            state,
            titleController,
            titleFocusNode,
              nextFocusNode,
             size,
             sendNewEvent),
          // Max Score Section

          _maxScores(state, sendNewEvent)
        ],
      ),
    );
  }

  Widget _maxScores(
      CreateTournamentData state,
      Function(CreateTournamentEvent) sendNewEvent
      ){
    int ms = state.maxScore?? 500;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Max Score",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => sendNewEvent(MinusMaxScoreEvent()),
                icon:
                const Icon(Icons.remove_circle, color: Colors.red, size: 51),
              ),
              Text(
                "$ms",
                style: const TextStyle(fontSize: 28),
              ),
              IconButton(
                onPressed: () => sendNewEvent(AddMaxScoreEvent()),
                icon: const Icon(Icons.add_circle, color: Colors.green, size: 51),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Second Part
  Widget _buildPart2(
      CreateTournamentData state,
      Function(CreateTournamentEvent) sendNewEvent
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPlayerList(state, sendNewEvent),
          // MAX/MIN Toggle
         /* Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'MAX',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'MIN',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:
              'Rew qrwrewe rwerwerw erwerwerewere wrew rwerwer rewrew rewre wrewrew rew rew rwere rwre erer!',
            ),
          )*/
        ],
      ),
    );
  }

// 7. Extract the title input section into a separate widget for better organization.
  Widget _buildTitleInput(AppLocalizations? localizations,
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
                isTextTitleEmpty = value
                    .trim()
                    .isEmpty;
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

  Widget _buildAddPlayerInput(AppLocalizations? localizations,
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
                if (playerNameController.text
                    .trim()
                    .isNotEmpty) {
                  addNewPlayer(AddPlayerEvent(playerNameController.text,
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
}

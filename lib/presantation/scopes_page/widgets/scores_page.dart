
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_notes/presantation/scopes_page/widgets/scores_board_widget.dart';
import '../../../application/common_widgets/ads_place_holder_widget.dart';
import '../../../application/common_widgets/pop_up_dialog.dart';
import '../../../application/scope_page/scope_bloc.dart';
import '../../../application/services/app_localizations.dart';
import '../../../domain/entities/score_board_item.dart';
import '../../create_tournament_page/scope_screen_arguments.dart';
import '../../manage_scopes_page/manage_scores_page_dialog.dart';

class ScopesPage extends StatefulWidget {
  const ScopesPage({super.key});

  @override
  State<ScopesPage> createState() => _ScopesPageState();
}

class _ScopesPageState extends State<ScopesPage> {
  late final ScopeBloc scopesBloc;
  late final args;

  @override
  void initState() {
    scopesBloc = BlocProvider.of<ScopeBloc>(context);
    super.initState();
  }

  void sendNewEvent(ScopeEvent newEvent) {
    scopesBloc.add(newEvent);
  }

  void showFinishTournamentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final localizations = AppLocalizations.fromContext(context);
        return Align(
          alignment: Alignment.topCenter,
          child: TopPopupDialog(
            errorType: localizations?.get("alert_warning") ?? 'Alert',
            message: localizations?.get("alert_finish_game") ?? "Do you want to finish game?",
            onAgree: () {
              sendNewEvent(FinishTournamentEvent());
              Navigator.pop(context);
            },
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScopeScreenArguments;
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    final localizations = AppLocalizations.fromContext(context);
    return BlocBuilder<ScopeBloc, ScopeState>(
      bloc: scopesBloc..add(LoadScopesEvent(arguments: args)),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              localizations?.get("title_s") ?? "Scores", // Pluralized for clarity.
              style: themeData.textTheme.displayLarge,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new), // Use a different icon// Change the color
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              if (state is LoadedDataState && !state.isFinished)
                Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.flag_circle_outlined),
                  iconSize: 40,
                  onPressed: () {
                    showFinishTournamentConfirmation(context);
                  },
                ),
              ),
            ],
          ),
          body: _buildBody(localizations, state, size, themeData,
              sendNewEvent), // Extract body building logic.
        );
      },
    );
  }

  // Improved: Extracted body building logic for better organization and readability.
  Widget _buildBody( AppLocalizations? localizations, ScopeState state, Size size, ThemeData themeData,
      Function(ScopeEvent) sendNewEvent) {
    if (state is LoadedDataState) {
      return SafeArea(
        child: Column(
          children: [
            ScoreBoardWidget(
              listOfScoresItems: state.listOfScoresBoardItems,
            ),
            const AdPlaceholderWidget(),
            if (!state.isFinished)
              ManageTournamentSection(
              size: size,
              state: state,
              sendNewEvent: sendNewEvent,
            ),
          ],
        ),
      );
    } else if (state is OnLoadingDataState) {
      return Center(
        child: CircularProgressIndicator(
          color: themeData.colorScheme.background,
        ),
      );
    } else {
      // Improved: Handle potential error states more explicitly.
      return Center(
          child: Text(localizations?.get("error_massage_s") ?? "An error occurred. Please try again later."));
    }
  }
}

class ManageTournamentSection extends StatelessWidget {
  final Size size;
  final Function(UpdatePlayerScoreEvent) sendNewEvent;
  final LoadedDataState state;

   const ManageTournamentSection(
      {super.key,
      required this.size,
      required this.state,
      required this.sendNewEvent});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.fromContext(context);
    void shoBottomSheet(List<ScoreBoardItem> listOfScoresBoardItems) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => BottomScreenDialogScreen(
          scoresBoardItems: listOfScoresBoardItems,
          // Pass the non-null data
          onUpdateScore: sendNewEvent,
        ),
      );
    }
    return SizedBox(
      height: 76,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            debugPrint("press manage scores button");
            shoBottomSheet(state.listOfScoresBoardItems);
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(49.0),
                  topRight: Radius.circular(49.0)),
            ),
          ),
          child: Text(localizations?.get("manage_btn_s") ?? "MANAGER"),
        ),
      ),
    );
  }
}


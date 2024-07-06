import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../application/services/app_localizations.dart';

class TournamentOverviewCard extends StatelessWidget {
  // 2. Use Named Parameters for Readability:
  // While not strictly necessary, using named parameters when calling the constructor
  // makes the code more self-documenting.final VoidCallback onPressed; // Use VoidCallback for callbacks without parameters
  final String tournamentName;
  final int playerCount;
  final bool isFinished; // Rename 'status' to be more descriptive
  final String winnerName;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  const TournamentOverviewCard({
    super.key,
    required this.tournamentName,
    required this.playerCount,
    required this.isFinished,
    required this.winnerName,
    required this.onPressed,
    required this.onLongPressed,
  });

  // 3. Inline Simple Getter:
  // The 'getStatus' method is very simple.You can inline it directly where it's used
  // to reduce verbosity.

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final localizations = AppLocalizations.fromContext(context);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed, // Directly use the callback
      onLongPress: onLongPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 100,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              color: themeData.colorScheme.onPrimary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 4. Extract Sub-Widgets:
                // The content within the Row is quite complex. Breaking itdown into
                // smaller, reusable widgets would improve readability and maintainability.
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // Wrap _buildTournamentInfo in Expanded
                          child: IntrinsicWidth(
                            // Use IntrinsicWidth to constrain width
                            child: _buildTournamentInfo(themeData, localizations),
                          ),
                        ),
                        Expanded(
                          // Wrap _buildWinnerInfo in Expanded
                          child: IntrinsicWidth(
                            child: _buildWinnerInfo(themeData),
                          ),
                        ),
                      ],
                    ),
                    // ),
                  ),
                ),
                _buildStatusIndicator(themeData, localizations, size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Example of extracted sub-widget:
  Widget _buildTournamentInfo(ThemeData themeData, AppLocalizations? localizations) {
    final String pl = localizations?.get('players') ?? "players";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          tournamentName,
          style: themeData.textTheme.bodyLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
        Text(
          "$pl : $playerCount",
          style: themeData.textTheme.bodyMedium,
          textAlign: TextAlign.left,
        )
      ]),
    );
  }

  Widget _buildWinnerInfo(ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: SvgPicture.asset(
            'assets/icons/csv_crown_icon.svg',
            height: 50,
            width: 70,
          ),
        ),
        Text(
          winnerName,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: themeData.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }

  Widget _buildStatusIndicator(ThemeData themeData, AppLocalizations? localizations, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: size.width * 0.07,
          color: isFinished ? Colors.deepOrangeAccent : Colors.green,
          child: RotatedBox(
              quarterTurns: 3,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    isFinished ? localizations?.get('finished') ?? "finished" : localizations?.get('active') ?? "active", // Inlined getStatus
                    style: themeData.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}

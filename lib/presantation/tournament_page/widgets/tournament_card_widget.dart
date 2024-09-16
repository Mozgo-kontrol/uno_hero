import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../application/common_widgets/anim_icon.dart';
import '../../../application/services/app_localizations.dart';

class TournamentOverviewCard extends StatelessWidget {
  // 2. Use Named Parameters for Readability:
  // While not strictly necessary, using named parameters when calling the constructor
  // makes the code more self-documenting.final VoidCallback onPressed; // Use VoidCallback for callbacks without parameters
  final String tournamentName;
  final int playerCount;
  final String createdAt; // Formated date in format String
  final bool isFinished;
  final String winnerName;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  const TournamentOverviewCard({
    super.key,
    required this.tournamentName,
    required this.playerCount,
    required this.winnerName,
    required this.onPressed,
    required this.onLongPressed,
    required this.createdAt,
    required this.isFinished,
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
                            child: _buildWinnerInfo(themeData, isFinished),
                          ),
                        ),
                      ],
                    ),
                    // ),
                  ),
                ),
                _buildStatusIndicator(themeData, localizations, size, createdAt),
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
        FittedBox(
          fit: BoxFit.fill,
          child: Text(
            tournamentName,
            style: themeData.textTheme.bodyLarge,
            maxLines: 1,

            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          "$pl : $playerCount",
          style: themeData.textTheme.bodyMedium,
          textAlign: TextAlign.left,
        )
      ]),
    );
  }

  Widget _buildWinnerInfo(ThemeData themeData, bool isFinished) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
          child: isFinished ? SvgPicture.asset(
            'assets/icons/csv_crown_icon.svg', height: 40,
            width: 60,
          ) : const AnimatedCrown(),
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

  Widget _buildStatusIndicator(ThemeData themeData, AppLocalizations? localizations, Size size, String createdAt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: size.width * 0.07,
          color: Colors.green,
          child: RotatedBox(
              quarterTurns: 3,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    createdAt, // Inlined getStatus
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

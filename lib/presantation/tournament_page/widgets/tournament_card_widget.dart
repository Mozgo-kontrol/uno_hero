import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uno_notes/application/utils/utils.dart';

/*class TournamentCardWidget extends StatelessWidget {
  final Function onPressed;
  final String tournamentName;
  final int playerCount;
  final bool status;
  final String winnerName;

  const TournamentCardWidget({
    super.key,
    required this.tournamentName,
    required this.playerCount,
    required this.status,
    required this.winnerName,
    required this.onPressed,
  });

  String getStatus() {
    return status ? "finished" : "current";
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onPressed(),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              Utils.makeStringShorter(tournamentName, 15),
                              style: themeData.textTheme.displayLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "players : $playerCount",
                                style: themeData.textTheme.displayLarge,
                                textAlign: TextAlign.start,
                              ),
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/icons/csv_crown_icon.svg',
                                height: 50,
                                width: 70,
                              ),
                            ),
                            Text(
                              Utils.makeStringShorter(winnerName, null),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: themeData.textTheme.displayLarge,
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: size.width * 0.07,
                      color: Colors.deepOrangeAccent,
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              getStatus(),
                              style: themeData.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
class TournamentOverviewCard extends StatelessWidget {
  // 2. Use Named Parameters for Readability:
  // While not strictly necessary, using named parameters when calling the constructor
  // makes the code more self-documenting.final VoidCallback onPressed; // Use VoidCallback for callbacks without parameters
  final String tournamentName;
  final int playerCount;
  final bool isFinished; // Rename 'status' to be more descriptive
  final String winnerName;
  final VoidCallback onPressed;

  const TournamentOverviewCard({
    super.key,
    required this.tournamentName,
    required this.playerCount,
    required this.isFinished,
    required this.winnerName,
    required this.onPressed,
  });

  // 3. Inline Simple Getter:
  // The 'getStatus' method is very simple.You can inline it directly where it's used
  // to reduce verbosity.

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed, // Directly use the callback
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
                            child: _buildTournamentInfo(themeData),
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
                _buildStatusIndicator(themeData, size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Example of extracted sub-widget:
  Widget _buildTournamentInfo(ThemeData themeData) {
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
          "players : $playerCount",
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

  Widget _buildStatusIndicator(ThemeData themeData, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: size.width * 0.07,
          color: Colors.deepOrangeAccent,
          child: RotatedBox(
              quarterTurns: 3,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  isFinished ? "finished" : "active", // Inlined getStatus
                  style: themeData.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ],
    );
  }
}

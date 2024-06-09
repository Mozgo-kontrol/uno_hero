import 'package:flutter/material.dart';

class TournamentCardWidget extends StatelessWidget {
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

  String getStatus (){
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
            width: size.width,
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
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          tournamentName,
                          style: themeData.textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "players : $playerCount",
                          style: themeData.textTheme.displayLarge,
                          textAlign: TextAlign.start,
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.accessibility), //TODO custom Icon
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "winner: $winnerName",
                          style: themeData.textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        )
                      ]),
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
                          child: Text(
                            getStatus(),
                            style: themeData.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
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
}

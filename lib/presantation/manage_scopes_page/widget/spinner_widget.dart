
import 'package:flutter/material.dart';
import 'package:wheel_spinner/wheel_spinner.dart';
import '../../create_tournament_page/widgets/CustomCardShape.dart';

// 1. Rename SpinnerWidget to ScoreSpinner for clarity.
class ScoreSpinner extends StatefulWidget {
  // 2. Rename onUpdateScorePlayer to onScoreChange for brevity and clarity.
  final Function(int) onScoreChange;
  const ScoreSpinner({super.key, required this.onScoreChange});

  @override
  State<ScoreSpinner> createState() => _ScoreSpinnerState();
}

class _ScoreSpinnerState extends State<ScoreSpinner> {
  late double value;

  @override
  void initState() {
    value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // 3. Extract the card styling into a separate widget for reusability.
    Widget buildScoreCard(Widget child) {
      return Card(
        elevation: 10,
        child: child,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height * 0.2,
        width: size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              // 4. Use the extracted card styling widget.
              child: buildScoreCard(
                WheelSpinnerTheme(
                  data: WheelSpinnerThemeData.light().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    dividerColor: Colors.black,
                  ),
                  child: WheelSpinner(
                    value: value,
                    min: -10.0,
                    // 5. Adjust max value as needed, 100 seems high for a score.
                    max: 100.0,
                    onSlideUpdate: (val) => setState(() {
                      value = val;
                      // 6. Use the renamed callback function.
                      widget.onScoreChange(value.toInt());
                    }),),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              // 7. Use the extracted card styling widget.
              child: buildScoreCard(
                Container( // 8. Use Container instead of Card for custom shape
                  decoration: const BoxDecoration(
                    //color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)), // Add rounded corners
                  ),
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_drop_up,),
                        Text(
                          value.toInt().toString(),
                          style: themeData.textTheme.headlineLarge,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
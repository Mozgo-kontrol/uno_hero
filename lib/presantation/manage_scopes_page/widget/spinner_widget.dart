
import 'package:flutter/material.dart';
import 'package:wheel_spinner/wheel_spinner.dart';

import '../../../application/services/app_localizations.dart';
import '../../create_tournament_page/widgets/CustomCardShape.dart';

class SpinnerWidget extends StatefulWidget {
  final Function(int) onUpdateScorePlayer;
  const SpinnerWidget({super.key, required this.onUpdateScorePlayer});

  @override
  State<SpinnerWidget> createState() => _SpinnerWidgetState();
}

class _SpinnerWidgetState extends State<SpinnerWidget> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height*0.2,
        width: size.width*0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                elevation: 10,
                child: WheelSpinnerTheme(
                  data: WheelSpinnerThemeData.light().copyWith(
                    borderRadius: BorderRadius.circular(10),
                    dividerColor: Colors.black,
                  ),
                  child: WheelSpinner(
                    value: value,
                    min: -10.0,
                    max: 100.0,
                    onSlideUpdate: (val) => setState(() {
                      value = val;
                      widget.onUpdateScorePlayer(value.toInt());
                    }),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 10,
                shape: const CustomCardShape(shapeColor: Colors.blue),
                child: Center(child: Text(value.toInt().toString(),style: themeData.textTheme.headlineLarge,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../application/utils/utils.dart';

class PlayerIconWithName extends StatelessWidget {
  const PlayerIconWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: 46,
        width: 46,
        child: Stack(
          children: [
            const SizedBox(
              height: 200,
              child: CircleAvatar(
                backgroundImage:
                    AssetImage("assets/icon/persons/Astronaut.png"),
                radius: 200,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.67),
                    borderRadius: BorderRadius.circular(10)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "player name",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayerIcon extends StatelessWidget {
  final int iconIndex;
  final double? iconHeight;
  final double? iconWidth;
  const PlayerIcon({super.key, required this.iconIndex, this.iconHeight = 46.0, this.iconWidth = 46.0});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
       height: iconHeight,
      width: iconWidth,
      Utils.getIconById(iconIndex)
    );
  }
}

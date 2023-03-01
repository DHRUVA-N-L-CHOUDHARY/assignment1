// ignore_for_file: prefer_contains

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<int?>> boxStates = List.generate(16, (index) => [0, null]);
  List<int?> coloredBoxes = [null, null];

  void push(int pos) {
    if (coloredBoxes.indexOf(pos) != -1) return;
    if (coloredBoxes[0] == null) {
      coloredBoxes[0] = pos;
    } else {
      if (coloredBoxes[1] == null) {
        coloredBoxes[1] = pos;
      } else {
        coloredBoxes[0] = coloredBoxes[1];
        coloredBoxes[1] = pos;
      }
    }
  }

  int cnt = 1;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight / 4,
            left: screenWidth / 10,
            right: screenWidth / 10),
        child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(
            16,
            (index) => GestureDetector(
              onTap: () {
                setState(
                  () {
                    for (int? pos in coloredBoxes) {
                      if (pos != null) {
                        boxStates[pos][0] = 0;
                      }
                    }
                    push(index);
                    boxStates[index][1] = cnt;
                    cnt += 1;
                    for (int? pos in coloredBoxes) {
                      if (pos != null) {
                        boxStates[pos][0] = 1;
                      }
                    }
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                  ),
                  color: boxStates[index][0] != 0
                      ? Colors.red
                      : Colors.blue.shade900,
                ),
                child: Text(
                  boxStates[index][1] != null
                      ? "Box #${boxStates[index][1]} "
                      : "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

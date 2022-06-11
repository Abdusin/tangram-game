import 'package:flutter/material.dart';
import 'package:gamepanel/models/game_item.dart';

class Level {
  final int gameBoardWidth;
  final int gameBoardHeight;
  final List<GameItem> gameItems;
  const Level({
    required this.gameBoardWidth,
    required this.gameBoardHeight,
    required this.gameItems,
  });
}

final levels = <Level>[
  Level(
    gameBoardWidth: 10,
    gameBoardHeight: 6,
    gameItems: [
      GameItem(
        id: 1,
        color: Colors.orange,
        matrix: [
          [1],
          [1, 1],
          [1, 1, 1],
          [1, 1, 1, 1],
          [1, 1, 1, 1],
          [1, 1, 1],
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 2,
        color: Colors.blue,
        matrix: [
          [1, 1, 1, 1],
          [1, 1, 1],
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 3,
        color: Colors.red,
        matrix: [
          [1, 1, 1, 1],
          [1, 1, 1],
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 4,
        color: Colors.green,
        matrix: [
          [1],
          [1],
          [1],
          [1],
          [1],
        ],
      ),
      GameItem(
        id: 5,
        color: Colors.yellow,
        matrix: [
          [1, 1, 0, 0],
          [1, 1, 1, 0],
          [0, 1, 1, 1],
          [0, 0, 1, 1],
        ],
      ),
      GameItem(
        id: 6,
        color: Colors.purple,
        matrix: [
          [0, 1, 0],
          [1, 1, 1],
          [0, 1, 0],
        ],
      ),
    ],
  ),
  Level(
    gameBoardWidth: 6,
    gameBoardHeight: 7,
    gameItems: [
      GameItem(
        id: 1,
        color: Colors.orange,
        matrix: [
          [1],
          [1, 1],
          [1, 1],
          [1, 1],
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 2,
        color: Colors.blue,
        matrix: [
          [1, 1, 1, 1, 1],
          [0, 0, 1],
          [0, 0, 1],
          [0, 0, 1],
        ],
      ),
      GameItem(
        id: 3,
        color: Colors.red,
        matrix: [
          [1, 1],
          [1, 1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 4,
        color: Colors.green,
        matrix: [
          [1, 1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 5,
        color: Colors.yellow,
        matrix: [
          [1, 1],
          [1],
          [1],
          [1],
        ],
      ),
      GameItem(
        id: 6,
        color: Colors.purple,
        matrix: [
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 7,
        color: Colors.pink,
        matrix: [
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 8,
        color: Colors.brown,
        matrix: [
          [1],
          [1, 1],
        ],
      ),
    ],
  ),
  Level(
    gameBoardWidth: 6,
    gameBoardHeight: 5,
    gameItems: [
      GameItem(
        id: 1,
        color: Colors.amber,
        matrix: [
          [1, 1, 1],
          [1],
          [1, 1, 1],
        ],
      ),
      GameItem(
        id: 2,
        color: Colors.blue,
        matrix: [
          [1, 1, 1],
          [1],
          [1],
        ],
      ),
      GameItem(
        id: 3,
        color: Colors.red,
        matrix: [
          [1, 1],
          [1],
          [1],
        ],
      ),
      GameItem(
        id: 4,
        color: Colors.green,
        matrix: [
          [1],
          [1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 5,
        color: Colors.yellow,
        matrix: [
          [1, 1],
          [1],
          [1],
        ],
      ),
      GameItem(
        id: 6,
        color: Colors.purple,
        matrix: [
          [1, 1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 7,
        color: Colors.pink,
        matrix: [
          [1, 1],
        ],
      ),
    ],
  ),
  Level(
    gameBoardWidth: 6,
    gameBoardHeight: 6,
    gameItems: [
      GameItem(
        id: 1,
        color: Colors.cyan,
        matrix: [
          [0, 1, 1],
          [0, 1, 1],
          [1, 1, 1],
          [1, 1, 1],
        ],
      ),
      GameItem(
        id: 2,
        color: Colors.deepOrange,
        matrix: [
          [1, 1],
          [1],
          [1],
          [1],
        ],
      ),
      GameItem(
        id: 3,
        color: Colors.pinkAccent,
        matrix: [
          [1, 1],
          [1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 4,
        color: Colors.green,
        matrix: [
          [0, 1, 1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 5,
        color: Colors.yellow,
        matrix: [
          [1],
          [1],
          [1, 1],
        ],
      ),
      GameItem(
        id: 6,
        color: Colors.purple,
        matrix: [
          [1],
          [1, 1],
          [1],
        ],
      ),
      GameItem(
        id: 7,
        color: Colors.lime,
        matrix: [
          [1, 1],
          [0, 1, 1],
        ],
      ),
    ],
  ),
];

import 'package:flutter/material.dart';
import 'package:gamepanel/models/game_item.dart';
import 'package:gamepanel/models/level.dart';
import 'package:gamepanel/utils/helpers.dart';
import 'package:gamepanel/utils/values.dart';
import 'package:get/get.dart';

class GameScreenController extends GetxController {
  var lastSize = const Offset(0, 0);
  var levelIndex = int.tryParse(Get.parameters['level'] ?? '0') ?? 0;
  late final level = levelIndex > levels.length - 1 ? levels.first : levels[levelIndex];

  @override
  void onInit() {
    super.onInit();
    _initItems();
  }

  void _initItems() {
    var startOffset = const Offset(50, 50);
    for (var i = 0; i < level.gameItems.length; i++) {
      var item = level.gameItems[i];
      var size = item.matrixLogenstLength * (itemSize + (gridSpace / 2));
      if (startOffset.dy + size > Get.height) {
        startOffset = Offset(startOffset.dx + 250, 50);
      }
      item.startOffset = startOffset;
      startOffset = startOffset.translate(0, size + 30);
    }
  }

  List<GameItem> get items => level.gameItems;
  int get gameBoardHeight => level.gameBoardHeight;
  int get gameBoardWidth => level.gameBoardWidth;

  Offset get _boardPosition => Offset(
      (Get.width / 2) - (gameBoardWidth * itemSize + (gameBoardWidth - 1) * gridSpace) / 2,
      (Get.height / 2) - (gameBoardHeight * itemSize + (gameBoardHeight - 1) * gridSpace) / 2);

  late Offset boardPosition = _boardPosition;

  void boardPositionSet() => boardPosition = _boardPosition;

  Offset getItemPosition(int row, int col) {
    return Offset(
      boardPosition.dx + col * itemSize + (col * gridSpace),
      boardPosition.dy + row * itemSize + (row * gridSpace),
    );
  }

  void onItemClicked(id) {
    var item = items.firstWhere((item) => item.id == id);
    item.rotateMatrix();
    if (filledIndexes.any((element) => element.third == id)) {
      filledIndexes.removeWhere((element) => element.third == id);
      item.filledIndexes.clear();
      item.itemOffset.value = item.startOffset;
    }
    update();
  }

  var filledIndexes = <Tupple3<int, int, dynamic>>[];
  onItemMoved(dynamic id, Offset newPosition) {
    var item = items.firstWhere((item) => item.id == id);
    var row = ((newPosition.dy) - boardPosition.dy) ~/ (itemSize + (gridSpace / 1));
    var col = ((newPosition.dx) - boardPosition.dx) ~/ (itemSize + (gridSpace / 1));
    row += item.selectedPixel.second;
    col += item.selectedPixel.first;
    if (row < 0 || row >= gameBoardHeight || col < 0 || col >= gameBoardWidth) {
      debugPrint('$id[$row, $col] out of bounds ${item.selectedPixel.first} ${item.selectedPixel.second}');
      item.itemOffset.value = newPosition;
      item.filledIndexes.clear();
      filledIndexes.removeWhere((item) => item.third == id);
      update();
      return;
    }

    row -= item.selectedPixel.second;
    col -= item.selectedPixel.first;

    List<Tupple3> newIndexes([bool addItemFilledList = false]) {
      var list = <Tupple3<int, int, dynamic>>[];
      for (var i = 0; i < item.matrix.length; i++) {
        for (var j = 0; j < item.matrix[i].length; j++) {
          if (item.matrix[i][j] == 1) {
            var newOne = Tupple3(i + row, j + col, item.id);
            if (newOne.first < 0 ||
                newOne.first >= gameBoardHeight ||
                newOne.second < 0 ||
                newOne.second >= gameBoardWidth) {
            } else {
              if (addItemFilledList) item.filledIndexes.add(Tupple(i, j));
              list.add(newOne);
            }
          }
        }
      }
      return list;
    }

    void addItemToBoard() {
      item.itemOffset.value = getItemPosition(row, col);
      debugPrint('$id[$row, $col] added to board at ${item.itemOffset.value}');
      filledIndexes.removeWhere((item) => item.third == id);
      item.filledIndexes.clear();
      filledIndexes.addAll(Iterable.castFrom(newIndexes(true)));
    }

    var indexes = newIndexes();
    if (filledIndexes.any((item) =>
        indexes.any((index) => index.first == item.first && index.second == item.second) && item.third != id)) {
      debugPrint('$id[$row, $col] already filled');
    } else {
      addItemToBoard();
    }
    if (filledIndexes.length == gameBoardWidth * gameBoardHeight) {
      var snackbar = Get.snackbar(
        'Game Over',
        'You won!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 10,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
      snackbar.future.then((value) {
        if (levelIndex < levels.length - 1) {
          Get.offAllNamed('/game', parameters: {'level': (levelIndex + 1).toString()});
        } else {
          Get.offAllNamed('/game', parameters: {'level': '0'});
        }
      });
    }
  }
}

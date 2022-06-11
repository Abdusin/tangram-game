import 'dart:math';
import 'dart:ui';

import 'package:gamepanel/utils/helpers.dart';
import 'package:get/get_rx/get_rx.dart';

class GameItem {
  final dynamic id;
  final List<List<int>> matrix;
  final filledIndexes = <Tupple<int, int>>[];
  late Offset startOffset;
  late Rx<Offset> itemOffset = startOffset.obs;
  final Color color;
  var matrixLogenstLength = 0;
  var longestIsHorizontal = true;
  var selectedPixel = const Tupple(0, 0);
  GameItem({
    required this.id,
    required this.matrix,
    required this.color,
  }) {
    for (var i = 0; i < matrix.length; i++) {
      matrixLogenstLength = max(matrixLogenstLength, matrix[i].length);
    }
    if (matrix.length > matrixLogenstLength) {
      matrixLogenstLength = matrix.length;
      longestIsHorizontal = false;
    }
    for (var row in matrix) {
      var addCount = matrixLogenstLength - row.length;
      for (var i = 0; i < addCount; i++) {
        row.add(0);
      }
    }
    var addCount = matrixLogenstLength - matrix.length;
    for (var i = 0; i < addCount; i++) {
      matrix.add(List.filled(matrixLogenstLength, 0));
    }
    firstSolidCell = _firstSolidCell();
    leftestSolidCell = _leftestSolidCell();
  }

  late Tupple<int, int> firstSolidCell;
  late Tupple<int, int> leftestSolidCell;

  void rotateMatrix() {
    var newMatrix = <List<int>>[];
    for (var col = 0; col < matrixLogenstLength; col++) {
      var newRow = <int>[];
      for (var row = 0; row < matrix.length; row++) {
        newRow.add(matrix[row][col]);
      }
      newMatrix.add(newRow.reversed.toList());
    }
    matrix.clear();
    matrix.addAll(newMatrix);
    firstSolidCell = _firstSolidCell();
    leftestSolidCell = _leftestSolidCell();
  }

  Tupple<int, int> _firstSolidCell() {
    for (var row = 0; row < matrix.length; row++) {
      for (var col = 0; col < matrix[row].length; col++) {
        if (matrix[row][col] == 1) {
          return Tupple(row, col);
        }
      }
    }
    return const Tupple(0, 0);
  }

  Tupple<int, int> _leftestSolidCell() {
    for (var col = 0; col < matrixLogenstLength; col++) {
      for (var row = 0; row < matrix.length; row++) {
        if (matrix[row][col] == 1) {
          return Tupple(row, col);
        }
      }
    }
    return const Tupple(0, 0);
  }
}

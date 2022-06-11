import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gamepanel/models/game_item.dart';
import 'package:gamepanel/utils/helpers.dart';
import 'package:gamepanel/utils/values.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class GameItemWidget extends StatelessWidget {
  const GameItemWidget(this.item, {Key? key, required this.onTap, required this.onMove}) : super(key: key);
  final GameItem item;
  final Function(dynamic) onTap;
  final Function(Offset) onMove;

  @override
  Widget build(BuildContext context) {
    final widget = MatrixWidget(item: item);
    return Obx(
      () => Positioned(
        top: item.itemOffset.value.dy,
        left: item.itemOffset.value.dx,
        child: InkWell(
          onTap: () => onTap(item.id),
          excludeFromSemantics: true,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: Draggable(
            data: item.id,
            childWhenDragging: const SizedBox.shrink(),
            feedback: widget,
            onDragEnd: (details) => onMove(details.offset),
            child: widget,
          ),
        ),
      ),
    );
  }
}

class MatrixWidget extends StatelessWidget {
  const MatrixWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final GameItem item;

  @override
  Widget build(BuildContext context) {
    var matrix = item.matrix;
    var longestLineInMatrix = item.matrixLogenstLength;
    var startIndex = matrix.length;
    for (var line in matrix) {
      startIndex = min(startIndex, line.indexOf(1));
    }
    if (longestLineInMatrix == 0) return const SizedBox.shrink();
    return SizedBox(
      width: longestLineInMatrix * itemSize + (longestLineInMatrix - 1) * gridSpace,
      height: matrix.length * itemSize + (matrix.length - 1) * gridSpace,
      child: Stack(
        children: [
          for (var i = 0; i < matrix.length; i++)
            for (var j = 0; j < matrix[i].length; j++)
              if (matrix[i][j] == 1)
                Positioned(
                  top: i * itemSize + (i * gridSpace),
                  left: (j) * itemSize + ((j) * gridSpace),
                  child: MouseRegion(
                    onHover: (_) => item.selectedPixel = Tupple(j, i),
                    child: Container(
                      width: itemSize,
                      height: itemSize,
                      decoration: BoxDecoration(
                        color: item.color,
                        border: item.filledIndexes.any((element) => element.first == i && element.second == j)
                            ? Border.all(color: Colors.black, width: 1)
                            : Border.all(color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

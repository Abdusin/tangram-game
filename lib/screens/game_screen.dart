import 'package:flutter/foundation.dart';
import 'package:gamepanel/utils/app_spaces.dart';
import 'package:gamepanel/utils/values.dart';
import 'package:gamepanel/widgets/game_item_widget.dart';
import 'package:gamepanel/widgets/particle_backround.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gamepanel/controllers/game_screen_controller.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ParticleBackground(
      opacity: .75,
      child: GetBuilder<GameScreenController>(
        init: GameScreenController(),
        autoRemove: true,
        global: false,
        builder: (controller) {
          return LayoutBuilder(builder: (context, constraints) {
            var newSize = Offset(constraints.maxWidth, constraints.maxHeight);
            if (newSize != controller.lastSize) {
              controller.lastSize = newSize;
              controller.boardPositionSet();
            }
            return SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                children: [
                  Center(
                    child: GameBoard(controller),
                  ),
                  for (var item in controller.items)
                    GameItemWidget(
                      item,
                      onTap: controller.onItemClicked,
                      onMove: (offset) => controller.onItemMoved(item.id, offset),
                    ),
                  if (kDebugMode)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Row(children: [
                          Column(children: [
                            const Text('filled Datas'),
                            for (var item in controller.filledIndexes) ...[
                              Text(
                                '[${item.third}] ${item.second}, ${item.first} ',
                                style: TextStyle(
                                  color: controller.items.firstWhere((element) => element.id == item.third).color,
                                ),
                              ),
                            ]
                          ]),
                          AppSpaces.horizontal5,
                          Column(children: [
                            const Text('filled items'),
                            for (var item in controller.items) ...[
                              for (var filled in item.filledIndexes)
                                Text(
                                  '[${item.id}] ${filled.first}, ${filled.second} ',
                                  style: TextStyle(
                                    color: item.color,
                                  ),
                                ),
                            ]
                          ]),
                        ]),
                      ),
                    )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard(this.controller, {Key? key}) : super(key: key);
  final GameScreenController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: controller.gameBoardWidth * itemSize + (controller.gameBoardWidth - 1) * gridSpace,
      height: controller.gameBoardHeight * itemSize + (controller.gameBoardHeight - 1) * gridSpace,
      child: DragTarget(
        onAcceptWithDetails: (details) {},
        builder: (context, _, __) {
          return Stack(
            children: [
              for (var i = 0; i < controller.gameBoardHeight; i++)
                for (var j = 0; j < controller.gameBoardWidth; j++)
                  Positioned(
                    top: i * itemSize + (i * gridSpace),
                    left: j * itemSize + (j * gridSpace),
                    child: Tooltip(
                      enableFeedback: kDebugMode,
                      message: '$j, $i',
                      child: Container(
                        width: itemSize,
                        height: itemSize,
                        color: Colors.blueGrey.withOpacity(0.6),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

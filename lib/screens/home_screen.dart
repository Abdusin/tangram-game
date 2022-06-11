import 'package:dotted_border/dotted_border.dart';
import 'package:gamepanel/utils/app_spaces.dart';
import 'package:gamepanel/widgets/particle_backround.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gamepanel/controllers/home_screen_controller.dart';
import 'package:hovering/hovering.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) {
        return ParticleBackground(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Stack(
                  children: [
                    Text(
                      'Tangram Game',
                      style: Get.textTheme.headline1,
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -5.0),
                      child: Text.rich(
                        TextSpan(
                          style: Get.textTheme.headline1,
                          children: const [
                            TextSpan(
                              text: 'Tan',
                              style: TextStyle(color: Colors.red),
                            ),
                            TextSpan(
                              text: 'gr',
                              style: TextStyle(color: Colors.yellow),
                            ),
                            TextSpan(
                              text: 'am',
                              style: TextStyle(color: Colors.green),
                            ),
                            TextSpan(
                              text: ' Game',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpaces.vertical20,
                StartGameButton(
                  onTap: () => Get.toNamed('/game', parameters: const {'level': '0'}),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StartGameButton extends StatelessWidget {
  const StartGameButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: HoverWidget(
        onHover: (event) {},
        hoverChild: DottedBorder(
          dashPattern: const [8, 4],
          strokeWidth: 3,
          color: Colors.blue,
          padding: const EdgeInsets.all(5.0),
          child: DottedBorder(
            dashPattern: const [4, 8],
            strokeWidth: 3,
            color: Colors.red,
            padding: const EdgeInsets.all(5.0),
            child: const SizedBox.square(
              dimension: 60,
              child: Icon(
                Icons.play_arrow_outlined,
                size: 40,
                color: Colors.green,
              ),
            ),
          ),
        ),
        child: DottedBorder(
          dashPattern: const [8, 4],
          strokeWidth: 3,
          color: Colors.red,
          padding: const EdgeInsets.all(5.0),
          child: DottedBorder(
            dashPattern: const [4, 8],
            strokeWidth: 3,
            color: Colors.blue,
            padding: const EdgeInsets.all(5.0),
            child: const SizedBox.square(
              dimension: 60,
              child: Icon(
                Icons.play_arrow_outlined,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

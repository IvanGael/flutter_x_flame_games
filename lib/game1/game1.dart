// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flame/parallax.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'game1_character.dart';
// import 'game1_world.dart';

// class MyFlameGame1 extends FlameGame with TapDetector, HasKeyboardHandlerComponents {
//   late Game1Character character;
//   late ParallaxComponent background;
//   SpriteComponent simpleBackground = SpriteComponent();

//   MyFlameGame1() : customWorld = Game1World() {
//     cameraComponent = CameraComponent(world: customWorld);
//   }

//   late final CameraComponent cameraComponent;
//   final Game1World customWorld;

//   @override
//   Future<void> onLoad() async {
//     addAll([cameraComponent, customWorld]);

//     background = await loadParallaxComponent(
//       [
//         ParallaxImageData('game1/background/layer1.jpg'),
//         ParallaxImageData('game1/background/layer2.jpg'),
//         ParallaxImageData('game1/background/layer3.jpg'),
//         ParallaxImageData('game1/background/layer4.jpg'),
//       ],
//       alignment: Alignment.center,
//       baseVelocity: Vector2(20, 0),
//       velocityMultiplierDelta: Vector2(1.5, 1.0),
//     );
//     add(background);

//     add(
//       simpleBackground
//       ..sprite = await loadSprite('game1/background/layer1.jpg')
//       ..size = Vector2(size[0], size[1])
//     );

//     character = Game1Character();
//     add(character);

//     camera.follow(character);
//   }

//   @override
//   void onTapDown(TapDownInfo info) {
//     super.onTapDown(info);
//     character.move(info.eventPosition.global, false);
//   }

//   @override
//   KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
//     character.handleKeyEvent(event, keysPressed);
//     return super.onKeyEvent(event, keysPressed);
//   }

//   void moveCharacter(LogicalKeyboardKey logicalKey, PhysicalKeyboardKey physicalKey, {bool running = false}) {
//     character.handleKeyEvent(
//       KeyDownEvent(
//         logicalKey: logicalKey,
//         physicalKey: physicalKey,
//         timeStamp: Duration.zero,
//       ),
//       {logicalKey},
//     );
//   }

//   void stopCharacter(LogicalKeyboardKey logicalKey, PhysicalKeyboardKey physicalKey) {
//     character.handleKeyEvent(
//       KeyUpEvent(
//         logicalKey: logicalKey,
//         physicalKey: physicalKey,
//         timeStamp: Duration.zero,
//       ),
//       {},
//     );
//   }
// }





import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game1_character.dart';
import 'game1_world.dart';

class MyFlameGame1 extends FlameGame with TapDetector, HasKeyboardHandlerComponents {
  late Game1Character character;
  late ParallaxComponent background;
  SpriteComponent simpleBackground = SpriteComponent();
  SpriteComponent ground = SpriteComponent();

  MyFlameGame1() : customWorld = Game1World() {
    cameraComponent = CameraComponent(world: customWorld);
  }

  late final CameraComponent cameraComponent;
  final Game1World customWorld;

  @override
  Future<void> onLoad() async {
    addAll([cameraComponent, customWorld]);

        background = await loadParallaxComponent(
      [
        ParallaxImageData('game1/background/layer1.jpg'),
        ParallaxImageData('game1/background/layer1.jpg'),
        ParallaxImageData('game1/background/layer1.jpg'),
        ParallaxImageData('game1/background/layer2.jpg'),
        ParallaxImageData('game1/background/layer2.jpg'),
        ParallaxImageData('game1/background/layer2.jpg'),
        // ParallaxImageData('game1/background/layer3.jpg'),
        ParallaxImageData('game1/background/layer4.jpg'),
        ParallaxImageData('game1/background/layer4.jpg')
      ],
      alignment: Alignment.center,
      baseVelocity: Vector2(5, 0),
      velocityMultiplierDelta: Vector2(1.2, 1.0),
    );
    add(background);

    // simpleBackground
    //   ..sprite = await loadSprite('game1/background/layer1.jpg')
    //   ..size = Vector2(size[0] * 10, size[1]); 
    // add(simpleBackground);
    ground
    ..sprite = await loadSprite('game1/background/ground.jpg')
    ..size = Vector2(size[0], 100)
    ..position = Vector2(0, size[1] - 18); 
    add(ground);

    character = Game1Character();
    add(character);

    camera.follow(character);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    character.move(info.eventPosition.global, false);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    character.handleKeyEvent(event, keysPressed);
    return super.onKeyEvent(event, keysPressed);
  }

  void moveCharacter(LogicalKeyboardKey logicalKey, PhysicalKeyboardKey physicalKey, {bool running = false}) {
    character.handleKeyEvent(
      KeyDownEvent(
        logicalKey: logicalKey,
        physicalKey: physicalKey,
        timeStamp: Duration.zero,
      ),
      {logicalKey},
    );
  }

  void stopCharacter(LogicalKeyboardKey logicalKey, PhysicalKeyboardKey physicalKey) {
    character.handleKeyEvent(
      KeyUpEvent(
        logicalKey: logicalKey,
        physicalKey: physicalKey,
        timeStamp: Duration.zero,
      ),
      {},
    );
  }
}

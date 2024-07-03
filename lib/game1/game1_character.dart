import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import 'game1.dart';

class Game1Character extends SpriteComponent with HasGameRef<MyFlameGame1> {
  double speed = 140;
  Vector2 velocity = Vector2.zero();

  Game1Character() : super(size: Vector2.all(84.0), position: Vector2(60, 320));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load the sprite for the character
    sprite = await gameRef.loadSprite('game1/character_walk.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Boundary checks to prevent the character from moving outside the screen height
    if (position.y < 0) {
      position.y = 0;
    } else if (position.y + size.y > gameRef.size.y) {
      position.y = gameRef.size.y - size.y;
    }

    // Check if the character reaches the width of the screen
    if (position.x + size.x > gameRef.size.x) {
      // Scroll the background by moving its position to the left
      gameRef.simpleBackground.position.x -= gameRef.size.x;
      // Reset the character position to the start of the screen width
      position.x = 0;
    }
  }

  void move(Vector2 direction, bool running) async {
    velocity = direction.normalized() * (speed / 2) * (running ? 4 : 2);
    await Future.delayed(const Duration(seconds: 2), () {
      velocity = Vector2(0, 0);
    });
  }

  void handleKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    Vector2 direction = Vector2.zero();
    bool running = false;

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      direction.y = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      direction.y = 1;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      direction.x = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      direction.x = 1;
    }

    if (keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
        keysPressed.contains(LogicalKeyboardKey.shiftRight)) {
      running = true;
    }

    move(direction, running);
  }
}

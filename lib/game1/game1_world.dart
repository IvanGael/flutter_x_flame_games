

import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import 'game1.dart';

class Game1World extends World with HasGameRef<MyFlameGame1>, KeyboardHandler {
  Game1World();
 
  // @override
  // bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //   
  // }
}
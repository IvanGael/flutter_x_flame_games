// ignore_for_file: library_private_types_in_public_api

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game1/game1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  // MyFlameGame1 game = MyFlameGame1();
  // runApp(
  //   GameWidget(game: kDebugMode ? MyFlameGame1() : game)
  // );
  runApp(GameApp());
}


// class GameApp extends StatelessWidget {
//   final MyFlameGame1 game = MyFlameGame1();

//   GameApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Stack(
//           children: [
//             GameWidget(game: game),
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     _buildControlButton(
//                       Icons.arrow_back,
//                       LogicalKeyboardKey.arrowLeft,
//                       PhysicalKeyboardKey.arrowLeft,
//                       onPress: () => game.moveCharacter(LogicalKeyboardKey.arrowLeft, PhysicalKeyboardKey.arrowLeft),
//                       onRelease: () => game.stopCharacter(LogicalKeyboardKey.arrowLeft, PhysicalKeyboardKey.arrowLeft),
//                     ),
//                     const SizedBox(width: 10),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _buildControlButton(
//                           Icons.arrow_upward,
//                           LogicalKeyboardKey.arrowUp,
//                           PhysicalKeyboardKey.arrowUp,
//                           onPress: () => game.moveCharacter(LogicalKeyboardKey.arrowUp, PhysicalKeyboardKey.arrowUp),
//                           onRelease: () => game.stopCharacter(LogicalKeyboardKey.arrowUp, PhysicalKeyboardKey.arrowUp),
//                         ),
//                         const SizedBox(height: 10),
//                         _buildControlButton(
//                           Icons.arrow_downward,
//                           LogicalKeyboardKey.arrowDown,
//                           PhysicalKeyboardKey.arrowDown,
//                           onPress: () => game.moveCharacter(LogicalKeyboardKey.arrowDown, PhysicalKeyboardKey.arrowDown),
//                           onRelease: () => game.stopCharacter(LogicalKeyboardKey.arrowDown, PhysicalKeyboardKey.arrowDown),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 10),
//                     _buildControlButton(
//                       Icons.arrow_forward,
//                       LogicalKeyboardKey.arrowRight,
//                       PhysicalKeyboardKey.arrowRight,
//                       onPress: () => game.moveCharacter(LogicalKeyboardKey.arrowRight, PhysicalKeyboardKey.arrowRight),
//                       onRelease: () => game.stopCharacter(LogicalKeyboardKey.arrowRight, PhysicalKeyboardKey.arrowRight),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildControlButton(IconData icon, LogicalKeyboardKey logicalKey, PhysicalKeyboardKey physicalKey, {required VoidCallback onPress, required VoidCallback onRelease}) {
//     return ElevatedButton(
//       onPressed: (){
//         onPress();
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.indigoAccent,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(20),
//       ),
//       child: Icon(icon, color: Colors.white,),
//     );
//   }
// }


class GameApp extends StatelessWidget {
  final MyFlameGame1 game = MyFlameGame1();

  GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: JoystickControl(
                  onDirectionChanged: (direction) {
                    switch (direction) {
                      case JoystickDirection.up:
                        game.moveCharacter(LogicalKeyboardKey.arrowUp, PhysicalKeyboardKey.arrowUp);
                        break;
                      case JoystickDirection.down:
                        game.moveCharacter(LogicalKeyboardKey.arrowDown, PhysicalKeyboardKey.arrowDown);
                        break;
                      case JoystickDirection.left:
                        game.moveCharacter(LogicalKeyboardKey.arrowLeft, PhysicalKeyboardKey.arrowLeft);
                        break;
                      case JoystickDirection.right:
                        game.moveCharacter(LogicalKeyboardKey.arrowRight, PhysicalKeyboardKey.arrowRight);
                        break;
                      case JoystickDirection.none:
                        // Stop the character when the joystick is released
                        game.stopCharacter(LogicalKeyboardKey.arrowRight, PhysicalKeyboardKey.arrowRight);
                        break;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum JoystickDirection { up, down, left, right, none }

class JoystickControl extends StatefulWidget {
  final void Function(JoystickDirection direction) onDirectionChanged;

  const JoystickControl({super.key, required this.onDirectionChanged});

  @override
  _JoystickControlState createState() => _JoystickControlState();
}

class _JoystickControlState extends State<JoystickControl> {
  Offset _startDragOffset = Offset.zero;
  Offset _currentDragOffset = Offset.zero;
  JoystickDirection _currentDirection = JoystickDirection.none;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _startDragOffset = details.localPosition;
      },
      onPanUpdate: (details) {
        setState(() {
          _currentDragOffset = details.localPosition - _startDragOffset;
          _currentDirection = _getDirectionFromOffset(_currentDragOffset);
          widget.onDirectionChanged(_currentDirection);
        });
      },
      onPanEnd: (details) {
        setState(() {
          _currentDragOffset = Offset.zero;
          _currentDirection = JoystickDirection.none;
          widget.onDirectionChanged(_currentDirection);
        });
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.5),
        ),
        child: Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Transform.translate(
              offset: _clampOffset(_currentDragOffset, -50, 50),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigoAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  JoystickDirection _getDirectionFromOffset(Offset offset) {
    const threshold = 20;
    if (offset.dy.abs() > offset.dx.abs()) {
      if (offset.dy < -threshold) return JoystickDirection.up;
      if (offset.dy > threshold) return JoystickDirection.down;
    } else {
      if (offset.dx < -threshold) return JoystickDirection.left;
      if (offset.dx > threshold) return JoystickDirection.right;
    }
    return JoystickDirection.none;
  }

  Offset _clampOffset(Offset offset, double min, double max) {
    final double clampedDx = offset.dx.clamp(min, max);
    final double clampedDy = offset.dy.clamp(min, max);
    return Offset(clampedDx, clampedDy);
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Container(),
//     );
//   }
// }


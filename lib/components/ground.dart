
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_flutter/game/assets.dart';
import 'package:game_flutter/game/configuration.dart';
import 'package:game_flutter/game/flappy_bird_game.dart';

class ground extends ParallaxComponent<flappybirdgame> with HasGameRef<flappybirdgame> {
  ground();

  @override
  Future<void>? onLoad() async {
    final ground = await Flame.images.load(assets.ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);
  }

  @override
  void update(double dt)
  {
    super.update(dt);
    //parallax?.baseVelocity.x = config.gamespeed;
  }
}

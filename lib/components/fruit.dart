
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'bird.dart';

class Fruit extends SpriteComponent with CollisionCallbacks {
  static const double speed = 200; // Kecepatan turun buah
  static final List<String> fruitImages = [
    '01.png',
    '02.png',
    '03.png',
    '04.png',
    '05.png',
    '06.png',
  ];

  Fruit({required Sprite sprite}) : super(sprite: sprite, size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
    // Set posisi awal di atas layar secara acak
    position = Vector2(Random().nextDouble() * (800 - size.x), 0); // 800 adalah lebar layar
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Gerakkan buah ke bawah
    position.y += speed * dt; // 200 piksel per detik

    if (position.y > 600) { // Menghapus buah jika melewati batas bawah layar
      removeFromParent();
      debugPrint('fruit removed');
    }
  }

  // Fungsi untuk memeriksa kolisi dengan burung
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    // Jika burung memakan buah
    if (other is Bird) {
      //FlameAudio.play('Minecraft_Eating.mp3');
      other.updatescore(); // Memperbarui skor burung
      removeFromParent(); // Menghapus buah dari permainan
    }
  }

  // Fungsi statis untuk menghasilkan buah secara acak
  static Future<Fruit> create() async {
    final randomIndex = Random().nextInt(fruitImages.length); // Ambil indeks acak untuk gambar buah
    final sprite = await Sprite.load(fruitImages[randomIndex]); // Memuat sprite dari gambar
    final fruit = Fruit(sprite: sprite);
    return fruit;
  }

  void spawnFruit() async {
    final fruit = await Fruit.create();
    add(fruit);
  }
}


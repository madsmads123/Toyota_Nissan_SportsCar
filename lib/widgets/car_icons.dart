import 'package:flutter/material.dart';

class CarIcons {
  static Widget getClassIcon(String classId, {double size = 56}) {
    final icons = {
      'class_0': _buildSupraMK1Icon(size),
      'class_1': _buildSupraMK2Icon(size),
      'class_2': _buildSupraMK3Icon(size),
      'class_3': _buildSupraMK4Icon(size),
      'class_4': _buildSupraMK5Icon(size),
      'class_5': _buildGTRC10Icon(size),
      'class_6': _buildGTRC110Icon(size),
      'class_7': _buildGTRR32Icon(size),
      'class_8': _buildGTRR33Icon(size),
      'class_9': _buildGTRR34Icon(size),
    };

    return icons[classId] ?? _buildDefaultIcon(size);
  }

  static Widget _buildSupraMK1Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.drive_eta, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.1,
          child: Text(
            'I',
            style: TextStyle(
              fontSize: size * 0.6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildSupraMK2Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.drive_eta, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.1,
          child: Text(
            'II',
            style: TextStyle(
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildSupraMK3Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.drive_eta, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.1,
          child: Text(
            'III',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildSupraMK4Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.local_taxi, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.05,
          child: Text(
            'IV',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildSupraMK5Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.local_taxi, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.05,
          child: Text(
            'V',
            style: TextStyle(
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildGTRC10Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.speed, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.08,
          child: Text(
            'C10',
            style: TextStyle(
              fontSize: size * 0.35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildGTRC110Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.speed, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.08,
          child: Text(
            'C110',
            style: TextStyle(
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildGTRR32Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.directions_car, size: size * 0.85, color: Colors.white.withValues(alpha: 0.9)),
        Icon(Icons.speed, size: size * 0.6, color: Colors.white.withValues(alpha: 0.7)),
        Positioned(
          bottom: size * 0.08,
          child: Text(
            'R32',
            style: TextStyle(
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildGTRR33Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.electric_car, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          bottom: size * 0.08,
          child: Text(
            'R33',
            style: TextStyle(
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildGTRR34Icon(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.directions_car, size: size, color: Colors.white.withValues(alpha: 0.9)),
        Positioned(
          top: size * 0.1,
          child: Icon(
            Icons.star,
            size: size * 0.4,
            color: Colors.yellow.withValues(alpha: 0.9),
          ),
        ),
        Positioned(
          bottom: size * 0.08,
          child: Text(
            'R34',
            style: TextStyle(
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildDefaultIcon(double size) {
    return Icon(
      Icons.directions_car,
      size: size,
      color: Colors.white.withValues(alpha: 0.9),
    );
  }
}

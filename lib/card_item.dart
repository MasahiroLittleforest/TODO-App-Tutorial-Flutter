import 'package:flutter/material.dart';

class CardItem {
  String title;
  IconData icon;
  int tasksRemaining;
  double taskCompletion;

  CardItem(
    this.title,
    this.icon,
    this.tasksRemaining,
    this.taskCompletion,
  );
}

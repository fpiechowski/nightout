import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

String loremPicsum({required Size size, int maxSeed = 10}) => "https://picsum.photos/seed/${random.integer(10)}/${size.width.toInt()}/${size.height.toInt()}";
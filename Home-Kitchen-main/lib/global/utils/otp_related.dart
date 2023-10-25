import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';

int GetOtp(){
  Random random = new Random();
  return random.nextInt(8998) + 1000;
}

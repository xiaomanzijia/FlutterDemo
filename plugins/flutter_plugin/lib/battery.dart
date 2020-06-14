import 'dart:async';

import 'package:flutter/services.dart';


/// Indicates the current battery state.
enum BatteryState {
  /// The battery is completely full of energy.
  full,

  /// The battery is currently storing energy.
  charging,

  /// The battery is currently losing energy.
  discharging
}

class Battery {

  static Stream<BatteryState> _onBatteryStateChanged;

  static const MethodChannel _channel =
      const MethodChannel('battery');

  static const EventChannel _eventChannel =
    const EventChannel('charging');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  
  static Future<String> get getBatteryLevel async {
    final String batteryLevel = await _channel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }

  /// Fires whenever the battery state changes.
  static Stream<BatteryState> get onBatteryStateChanged {
    if (_onBatteryStateChanged == null) {
      _onBatteryStateChanged = _eventChannel
          .receiveBroadcastStream()
          .map((dynamic event) => _parseBatteryState(event));
    }
    return _onBatteryStateChanged;
  }
}

BatteryState _parseBatteryState(String state) {
  switch (state) {
    case 'full':
      return BatteryState.full;
    case 'charging':
      return BatteryState.charging;
    case 'discharging':
      return BatteryState.discharging;
    default:
      throw ArgumentError('$state is not a valid BatteryState.');
  }
}
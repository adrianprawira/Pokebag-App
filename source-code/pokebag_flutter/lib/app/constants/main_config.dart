import 'package:flutter/foundation.dart';

///Check If App Running in Debug Mode.
bool get isDebugMode => kDebugMode;

///Check If App Running in Profile Mode.
bool get isProfileMode => kProfileMode;

///Check If App Running in Release Mode.
bool get isReleaseMode => kReleaseMode;

/// Hide Log and Print in Release Mode.
void hideLogNPrint() => isReleaseMode
    ? debugPrint = (String? message, {int? wrapWidth}) => null
    : null;

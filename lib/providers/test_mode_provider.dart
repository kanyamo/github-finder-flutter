import 'package:flutter_riverpod/flutter_riverpod.dart';

// テストモードかどうか
// 通常はfalseを返す。テストの時のみtrueでオーバーライドする
final testModeProvider = Provider<bool>((ref) => false);

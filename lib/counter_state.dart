import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

part 'counter_state.g.dart';
part 'counter_state.freezed.dart';


///mutableのパターン
// ///
// ///Provider
// final counterProvider = StateNotifierProvider<CounterState, Counter>((ref) => CounterState());
//
// ///state
// class CounterState extends StateNotifier<Counter> {
//   CounterState() : super(Counter());
//
//   void countUp() {
//     state.count ++ ;
//     print(state.count);
//   }
// }
//
// /// stateで保持するデータクラス
// class Counter {
//   int count = 0;
//
// }

///immutableのパターン
//以下をターミナルで実行する
// flutter packages pub run build_runner build --delete-conflicting-outputs

///Provider
final counterProvider =
StateNotifierProvider<CounterState, Counter>((ref) => CounterState());

///state
class CounterState extends StateNotifier<Counter> {
  CounterState() : super(const Counter());

  void countUp() {
    state = state.copyWith(
      ///immutableなので'++'という概念は通じない（？）クラス外の数字を直接読まないから。
      count: state.count + 1,
    );
  }
}

/// stateで保持するデータクラス


///最初はエラーがでるので、以下コマンドをターミナルで実行する
///flutter pub run build_runner build --delete-conflicting-outputs
/// ※注意点は以下二つのおまじないを書いておくこと。build_runnerが上手く生成されない。
/// part 'counter_state.freezed.dart';
/// part 'counter_state.g.dart';
///
/// ここではint型のcountとcount10、という変数を宣言している。
@freezed
abstract class Counter with _$Counter {
  const factory Counter({
    @Default(0) int count,
    //@Default(0) int count10,
  }) = _Counter;

  factory Counter.fromJson(Map<String, dynamic> json) =>
      _$CounterFromJson(json);
}
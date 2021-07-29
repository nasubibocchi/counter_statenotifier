import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'counter_state.dart';

void main() {
  runApp (
    ProviderScope(
      child: MyCounterApp(),
    ),
  );
}

class MyCounterApp extends HookWidget {
  @override
  ///ConsumerWidgetを使う場合
  //Widget build(BuildContext context, ScopedReader watch) {
    // Counter state = watch(counterProvider);
    // CounterState counter = watch(counterProvider.notifier);
  ///hookwidgetを使う場合
  Widget build(BuildContext context) {
    //counterはCounterState型であり、countを監視している。
    final state = useProvider(counterProvider.select((value) => value));
    //controllerはCounterStateController型なので、countUp()を実行できる。
    final counter = useProvider(counterProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          ///ボタンを押したらstateが変化するcountという変数@counter_stateを表示する
          child: Text(state.count.toString()),
        ),
        floatingActionButton: FloatingActionButton(
          ///Count()という'count'が１増える関数@counter_stateを呼び出す
          onPressed: () {
            counter.countUp();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

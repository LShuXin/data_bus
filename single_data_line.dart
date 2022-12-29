import 'dart:async';
import 'package:flutter/material.dart';
import './data_observer_widget.dart';

class SingleDataLine<T> {
  late StreamController<T> _stream;

  //拿到当前最新的数据
  T? currentData;

  SingleDataLine([T? initData]) {
    currentData = initData;
    _stream = StreamController.broadcast();
    if (initData != null) {
      _stream.add(initData);
    }
  }

  get outer => _stream.stream;

  get inner => _stream.sink;

  void setData(T t) {
    if (t == currentData) {
      return;
    }
    if (_stream.isClosed) {
      return;
    }
    print("发送了一次数据 $t");
    currentData = t;
    inner.add(t);
  }

  Widget addObserver(Widget Function(BuildContext context, T data) observer) {
    return DataObserverWidget<T>(this, observer);
  }

  void dispose() {
    _stream.close();
  }
}

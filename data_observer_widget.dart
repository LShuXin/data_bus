import 'package:flutter/material.dart';
import 'single_data_line.dart';

class DataObserverWidget<T> extends StatefulWidget {
  final SingleDataLine<T> _dataLine;
  final Widget Function(BuildContext ctx, T state) _builder;

  DataObserverWidget(this._dataLine, this._builder);

  @override
  State<StatefulWidget> createState() {
    return _DataObserverWidgetState<T>();
  }
}

class _DataObserverWidgetState<T> extends State<DataObserverWidget<T>> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: widget._dataLine.outer,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot != null && snapshot.data != null) {
          print(" ${context.widget.toString()} 中的steam接收到了一次数据${snapshot.data}");
          return widget._builder(context, snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._dataLine.dispose();
  }
}

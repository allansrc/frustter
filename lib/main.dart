import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';

import 'core/frustter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frustter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Frustter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String nameStr = "Allan Ramos";

  Pointer<Utf8> loadName() {
    final Pointer<Utf8> namePtr = nameStr.toNativeUtf8().cast(); // old Utf8.toUtf8(nameStr);
    print("- Calling rust_greeting with argument:  $namePtr");
    return namePtr;
  }

  callRustFunction() {
    final Pointer<Utf8> resultPtr = Frustter.frustter(loadName());
    print("- Result pointer:  $resultPtr");
  }

  handlePointerResult() {
    final String frustterStr = callRustFunction().toNativeUtf8().cast();
    print("- Response string:  $frustterStr");
    return frustterStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

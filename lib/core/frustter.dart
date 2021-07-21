import 'dart:io';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

const DYNAMIC_LIB_ANDROID = 'librust_ffi.so';

typedef GreetingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef GreetingFunctionFFI = Pointer<Utf8> Function(Pointer<Utf8>);

class Frustter {
  final DynamicLibrary frustterAndroid = DynamicLibrary.open(DYNAMIC_LIB_ANDROID);

  static DynamicLibrary _loadLibrary2Platforms = Platform.isAndroid ? DynamicLibrary.open(DYNAMIC_LIB_ANDROID) : DynamicLibrary.process();

  static GreetingFunction frustter = _loadLibrary2Platforms.lookup<NativeFunction<GreetingFunctionFFI>>("rust_ffi").asFunction();
}

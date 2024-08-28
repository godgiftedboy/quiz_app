import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAsyncValueWidget<T> extends ConsumerWidget {
  const MyAsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading = const Center(
      child: CircularProgressIndicator(),
    ),
    this.passError = false,
    this.error = const Text(""),
    this.passLoaderHeight = false,
    this.height = 0.0,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget loading;
  final bool passError;
  final Widget error;
  final bool passLoaderHeight;
  final double height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: data,
      error: (err, s) {
        log("from main error: ${err.toString()}");
        log("from main stacktrace: ${s.toString()}");

        //For async notifier
        // var fromAsync = err.toString().contains("FutureOr");
        return Center(
          child: Text(
            err.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
      loading: () => loading,
    );
  }
}

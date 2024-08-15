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
    this.fromCourse = false,
    this.passLoaderHeight = false,
    this.height = 0.0,
    this.fromMain = false,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget loading;
  final bool passError;
  final Widget error;
  final bool fromCourse;
  final bool passLoaderHeight;
  final double height;
  final bool fromMain;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: data,
      error: (err, s) {
        //For async notifier
        var fromAsync = err.toString().contains("FutureOr");
        return passError
            ? error
            : fromAsync
                ? passLoaderHeight
                    ? fromMain
                        ? Material(
                            child: SizedBox(
                              height: height,
                              child: loading,
                            ),
                          )
                        : SizedBox(
                            height: height,
                            child: loading,
                          )
                    : fromMain
                        ? Material(
                            child: loading,
                          )
                        : loading
                : fromCourse
                    ? Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                        ),
                        body: Center(
                          child: Text(err.toString(),
                              style: const TextStyle(color: Colors.white)),
                        ),
                      )
                    : fromMain
                        ? Material(
                            child: Center(
                              child: Text("$err",
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          )
                        : Center(
                            child: Text(
                              err.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
      },
      loading: () => fromMain
          ? Material(
              child: loading,
            )
          : loading,
    );
  }
}

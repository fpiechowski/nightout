import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/utils/gradient_card.dart';

class Error extends ConsumerWidget {
  final Object error;
  final StackTrace? stackTrace;
  final ProviderBase<dynamic>? retry;

  const Error(this.error, {this.stackTrace, Key? key, this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrintStack(stackTrace: stackTrace, label: error.toString());

    return Column(
      children: [
        GradientCard(
          padding: const EdgeInsets.all(8),
          elevation: 5,
          color: Theme.of(context).colorScheme.error,
          child: Column(
            children: [
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                stackTrace.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  if (retry != null)
                    TextButton(
                      onPressed: () async => await ref.refresh(retry!),
                      child: const Text("Retry"),

                    ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

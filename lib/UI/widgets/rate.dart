import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// The body of the main Rate my app test widget.
class RateApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => RateAppState();
}

/// The body state of the main Rate my app test widget.
class RateAppState extends State<RateApp> {
  /// The widget builder.
  WidgetBuilder builder = buildProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate my app Demo'),
      ),
      body: RateMyAppBuilder(
        builder: builder,
        onInitialized: (context, rateMyApp) {
          setState(()

          => builder = (context) => ContentWidget(rateMyApp: rateMyApp));  /// Comment this line before release

///          async {await rateMyApp.showRateDialog(context);});  /// Uncomment this line before release

          rateMyApp.conditions.forEach((condition) {
            if (condition is DebuggableCondition) {
              print(condition.valuesAsString); // We iterate through our list of conditions and we print all debuggable ones.
            }
          });

          print('Are all conditions met ? ' + (rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));

          if (rateMyApp.shouldOpenDialog) {
            rateMyApp.showRateDialog(context);
          }
        },
      ),
  );
  }
  /// Builds the progress indicator, allowing to wait for Rate my app to initialize.
  static Widget buildProgressIndicator(BuildContext context) => const Center(
      child: CircularProgressIndicator()
  );
}



/// The app's main content widget.
class ContentWidget extends StatefulWidget {
  /// The Rate my app instance.
  final RateMyApp rateMyApp;

  /// Creates a new content widget instance.
  const ContentWidget({
    @required this.rateMyApp,
  });

  @override
  State<StatefulWidget> createState() => ContentWidgetState();
}

/// The content widget state.
class ContentWidgetState extends State<ContentWidget> {
  /// Contains all debuggable conditions.
  List<DebuggableCondition> debuggableConditions = [];

  /// Whether the dialog should be opened.
  bool shouldOpenDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RaisedButton(
                child: const Text('Launch "Rate my app" dialog'),
                onPressed: () async {
                  await widget.rateMyApp.showRateDialog(
                      context); // We launch the default Rate my app dialog.
                  refresh();
                },
              ),
            ),
          ],
        ),
      );

  /// Returns a centered text.
  Text textCenter(String content) =>
      Text(
        content,
        textAlign: TextAlign.center,
      );

  /// Allows to refresh the widget state.
  void refresh() {
    setState(() {
      debuggableConditions =
          widget.rateMyApp.conditions.whereType<DebuggableCondition>().toList();
      shouldOpenDialog = widget.rateMyApp.shouldOpenDialog;
    });
  }
}
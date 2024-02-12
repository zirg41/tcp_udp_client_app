import "package:flutter/material.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Initial Project",
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Initial Project")),
        body: const Center(child: Text("env")),
      ),
    );
  }
}

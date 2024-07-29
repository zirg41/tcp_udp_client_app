import "package:flutter/material.dart";

class UIKitScreen extends StatelessWidget {
  const UIKitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UI Kit Screen"),
      ),
      body: const Center(
        child: Text("empty page"),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:tcp_udp_client_app/core/qa/developer_page/pages/ui_kit_screen.dart";

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 10,
        centerTitle: true,
        title: const Text(
          "Developer page",
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _UIKitButtonWidget(),
            // TODO(faiz): app pages here
          ],
        ),
      ),
    );
  }
}

class _UIKitButtonWidget extends StatelessWidget {
  const _UIKitButtonWidget();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<dynamic>(
            builder: (context) => const UIKitScreen(),
          ),
        );
      },
      child: const Text(
        "UI Kit Page",
      ),
    );
  }
}

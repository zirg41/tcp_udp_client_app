import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:tcp_udp_client_app/core/routes/routes.dart";

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => context.go(AppRoutes.tcp),
              child: Text("Open TCP Page"),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.udp),
              child: Text("Open UDP Page"),
            ),
          ],
        ),
      ),
    );
  }
}

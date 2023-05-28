import 'package:flutter/material.dart';


class BuildRefuseScreen extends StatelessWidget {
  const BuildRefuseScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Votre compte a été refusé."),
          // Ajoutez d'autres éléments UI ou des actions si nécessaire
        ],
      ),
    );
  }
}

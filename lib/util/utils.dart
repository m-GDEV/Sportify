import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import '../main.dart';

  Future<String> generateSummary(BuildContext context, String prompt, [bool listen = true]) async {
    var appstate = context.read<MyAppState>(); // use read to avoid rebuild loops
    try {
      final content = [Content.multi([TextPart(prompt)])];
      var res = await appstate.model.generateContent(content);
      return res.text ?? "No summary generated.";
    } catch (e) {
      print("Error generating summary: $e");
      return "Error generating summary.";
    }
  }
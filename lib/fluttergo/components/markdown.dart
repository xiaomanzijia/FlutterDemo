import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/utils/high_light_code.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;

class HighLight extends md.SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    final SyntaxHighlighterStyle style =
        SyntaxHighlighterStyle.lightThemeStyle();

    return TextSpan(
        style: const TextStyle(
          fontSize: 10.0,
        ),
        children: <TextSpan>[DartSyntaxHighlighter(style).format(source)]);
  }
}

class MarkdownBody extends StatelessWidget {
  final String data;

  MarkdownBody(this.data);

  @override
  Widget build(BuildContext context) {
    return md.MarkdownBody(
      data: data,
      syntaxHighlighter: new HighLight(),
    );
  }
}

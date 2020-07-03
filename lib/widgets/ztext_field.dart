import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ZTextFieldWidget(),
      ),
    ));

class ZTextFieldWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ZTextFieldWidget();
}

class _ZTextFieldWidget extends State<ZTextFieldWidget> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  bool showLabel = false;
  bool filled = true;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        showLabel = controller.text.isEmpty && focusNode.hasFocus;
        filled = !focusNode.hasFocus;
      });
    });
    focusNode.addListener(() {
      setState(() {
        showLabel = controller.text.isEmpty && focusNode.hasFocus;
        filled = !focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          ZTextField(
            hintText: '机构名称',
            labelText: '',
          ),
          SizedBox(
            height: 0.0,
          ),
          ZTextField(
            obscure: true,
            controller: controller,
            focusNode: focusNode,
            showLabel: false,
            filled: filled,
            hintText: '统一社会信用代码',
          )
        ],
      ),
    );
  }
}

///自定义输入框
class ZTextField extends StatefulWidget {
  final String hintText;
  final bool filled;
  final String labelText;
  final showLabel;

  final TextEditingController controller;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextDirection textDirection;
  final bool autofocus;
  final bool obscure;
  bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int maxLines;
  final int minLines;
  final bool expands;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  static const int noMaxLength = -1;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;

  bool get selectionEnabled => enableInteractiveSelection;
  final GestureTapCallback onTap;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollPhysics scrollPhysics;
  final ScrollController scrollController;
  final TextInputType keyboardType;

  ZTextField({
    this.controller,
    this.showLabel = false,
    this.focusNode,
    this.decoration,
    this.hintText = '',
    this.labelText = '',
    this.filled = true,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscure = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.smartDashesType,
    this.smartQuotesType,
    this.toolbarOptions,
  });

  @override
  State<StatefulWidget> createState() => _ZTextFiledState();
}

class _ZTextFiledState extends State<ZTextField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Offstage(
              offstage: (widget.labelText?.isEmpty ?? true) || !widget.showLabel,
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width - 32,
                height: 48.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  color: Colors.yellow,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Text(
                    widget.labelText,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Offstage(
              offstage: (widget.labelText?.isEmpty ?? true) || !widget.showLabel,
              child: SizedBox(
                height: 34.0,
              ),
            ),
            Container(
              height: 60,
              child: Stack(
                children: <Widget>[
                  TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    style: widget.style ??
                        TextStyle(color: const Color(0xFF1C2026), fontSize: 16.0),
                    decoration: widget.decoration ??
                        InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          filled: true,
                          focusColor: Colors.blue,
                          fillColor: widget.filled ? const Color(0xFFF9F9FB) : Colors.white,
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                              color: const Color(0xFFA5ABB6), fontSize: 16.0),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue, width: 0.5),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                              gapPadding: 4.0),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xFFF9F9FB), width: 0.5),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                              gapPadding: 4.0),
                        ),
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    textCapitalization: widget.textCapitalization,
                    strutStyle: widget.strutStyle,
                    textAlign: widget.textAlign,
                    textAlignVertical: widget.textAlignVertical,
                    textDirection: widget.textDirection,
                    readOnly: widget.readOnly,
                    toolbarOptions: widget.toolbarOptions,
                    showCursor: widget.showCursor,
                    autofocus: widget.autofocus,
                    obscureText: widget.obscureText,
                    autocorrect: widget.autocorrect,
                    smartDashesType: widget.smartDashesType,
                    smartQuotesType: widget.smartQuotesType,
                    enableSuggestions: widget.enableSuggestions,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    expands: widget.expands,
                    maxLength: widget.maxLength,
                    maxLengthEnforced: widget.maxLengthEnforced,
                    onChanged: widget.onChanged,
                    onEditingComplete: widget.onEditingComplete,
                    onSubmitted: widget.onSubmitted,
                    inputFormatters: widget.inputFormatters,
                    enabled: widget.enabled,
                    cursorWidth: widget.cursorWidth,
                    cursorRadius: widget.cursorRadius,
                    cursorColor: widget.cursorColor,
                    selectionHeightStyle: widget.selectionHeightStyle,
                    selectionWidthStyle: widget.selectionWidthStyle,
                    keyboardAppearance: widget.keyboardAppearance,
                    scrollPadding: widget.scrollPadding,
                    dragStartBehavior: widget.dragStartBehavior,
                    enableInteractiveSelection: widget.enableInteractiveSelection,
                    onTap: widget.onTap,
                    buildCounter: widget.buildCounter,
                    scrollController: widget.scrollController,
                    scrollPhysics: widget.scrollPhysics,
                  ),
                  Positioned(
                    right: 2.0,
                    child: Row(
                      children: <Widget>[
                        Offstage(
                          offstage: widget.controller == null ||
                              widget.controller.text.isEmpty,
                          child: IconButton(
                            onPressed: () {
                              widget.controller?.clear();
                            },
                            icon: Icon(
                              Icons.clear,
                              size: 20,
                              color: const Color(0xFF9B9B9B),
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: !widget.obscure,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.obscureText = !widget.obscureText;
                              });
                            },
                            icon: Icon(
                              widget.obscureText ? Icons.error : Icons.message,
                              size: 20,
                              color: const Color(0xFF9B9B9B),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

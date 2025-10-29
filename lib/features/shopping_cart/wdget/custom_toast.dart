import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
    required bool isError,
    Color textColor = Colors.white,
    double borderRadius = 8.0,
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    TextStyle? textStyle,
    Alignment alignment = Alignment.bottomCenter,
    double bottomMargin = 50.0,
  }) {
    // Cancel any existing toast first
    dismiss();

    // Create overlay entry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Align(
              alignment: alignment,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: bottomMargin,
                  left: 20.0,
                  right: 20.0,
                ),
                decoration: BoxDecoration(
                  color: isError ? Colors.red : Colors.lightGreen,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: padding,
                child: Text(
                  message,
                  style: GoogleFonts.montserrat(
                    color: isError ? Colors.white : Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );

    // Insert the overlay into the current context
    Overlay.of(context).insert(_overlayEntry!);

    // Schedule automatic dismissal
    _timer = Timer(duration, () => dismiss());
  }

  static void dismiss() {
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

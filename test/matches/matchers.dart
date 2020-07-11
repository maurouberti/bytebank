import 'package:bytebank/components/editor.dart';
import 'package:bytebank/screens/menu/menu.dart';
import 'package:flutter/material.dart';

bool botaMenuMatcher(Widget widget, textobotao, icone) {
  if (widget is BotaoMenu) {
    return widget.textoBotao == textobotao && widget.icone == icone;
  }
  return false;
}

bool editorMatcher(Widget widget, String rotulo) {
  if (widget is Editor) {
    return widget.rotulo == rotulo;
  }
  return false;
}

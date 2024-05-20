import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../common/util/exports.dart';

class ChatController extends GetxController {
  var chat = TextEditingController();
  var textChat = "".obs;
  late IOWebSocketChannel _channel;
  StreamController<String> _streamController = StreamController<String>();

  @override
  onInit() {
    connect();
    super.onInit();
  }

  void connect() {
    String? ip = Storage.getValue<String>('ip');
    print('Received message: $ip');
    _channel = IOWebSocketChannel.connect('ws://$ip:8000/ws');
    _channel.stream.listen((message) {
      // Xử lý tin nhắn mới
      print('Received message: $message');
    });
  }

  // Đóng kết nối WebSocket
  void disconnect() {
    _channel.sink.close();
  }

  // Gửi tin nhắn qua kết nối WebSocket
  void sendMessage() {
    print(chat.text);
    _channel.sink.add(chat.text);
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}

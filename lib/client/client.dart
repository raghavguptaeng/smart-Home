import 'dart:io';
import 'dart:typed_data';

import 'package:home/main.dart';
class IOT{
  void connect(String device) async {
    // connect to the socket server
    // listen for responses from the server
    var socket = await Socket.connect('192.168.1.40', 5000);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
    socket.listen(
      // handle data from the server
          (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
        if(serverResponse == 'Ack'){
          socket.destroy();
        }
      },

      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    await sendMessage(socket, device);
  }

  Future<void> sendMessage(Socket socket, String device) async {
    print('Client: $device');
    socket.write(device);
    await Future.delayed(Duration(seconds: 2));
  }
}
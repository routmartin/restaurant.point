import 'package:socket_io_client/socket_io_client.dart' as IO;

void client() {
  print('call');

  IO.Socket socket = IO.io('http://192.168.0.149:3000', <String, dynamic>{
    'transports': ['websocket'],
  });
  socket.on('connect', (_) {
    print('connect');
  });
  socket.on('hi', (data) {
    print(data);
  });

  socket.emit('hello', 'hi from Martin');

  socket.on('reply', (data) {
    print(data);
  });
}

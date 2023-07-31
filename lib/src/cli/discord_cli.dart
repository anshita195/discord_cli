// cli/discord_cli.dart

import '../db/db_helper.dart';
import 'dart:io';

void discordCli() async {
  final dbHelper = DbHelper();
  await dbHelper.openDatabase();

  print('Enter a command (register/login/logout <username> or exit):');

  while (true) {
    final input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) continue;

    final args = input.split(' ');
    final command = args[0].toLowerCase();

    if (command == 'exit') {
      print('Exiting Discord CLI.');
      break;
    } else if (command == 'register') {
      if (args.length < 2) {
        print('Usage: register <username>');
        continue;
      }
      final username = args[1];
      dbHelper.registerUser(username);
    } else if (command == 'login') {
      if (args.length < 2) {
        print('Usage: login <username>');
        continue;
      }
      final username = args[1];
      dbHelper.loginUser(username);
    } else if (command == 'logout') {
      if (args.length < 2) {
        print('Usage: logout <username>');
        continue;
      }
      final username = args[1];
      dbHelper.logoutUser(username);
    } else {
      print('Unknown command: $command');
    }
  }
}

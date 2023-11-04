import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prova_flutter/login.dart';

void main() {
  group('Login Page Tests', () {
    testWidgets('Validate if both fields are filled',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Login()));

      // Tap the login button without entering any data
      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(find.text('Obrigatório'), findsNWidgets(2));
    });

    testWidgets('Validate password length', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Login()));

      // Enter a password with less than 2 characters
      await tester.enterText(find.byType(TextFormField).at(0), 'user');
      await tester.enterText(find.byType(TextFormField).at(1), 'a');
      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(find.text('Deve conter no mínimo 2 caracteres'), findsOneWidget);
    });

    testWidgets('Validate special characters in the password',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Login()));

      // Enter a password with special characters
      await tester.enterText(find.byType(TextFormField).at(0), 'user');
      await tester.enterText(find.byType(TextFormField).at(1), 'P@ssw0rd');
      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(
          find.text(
              'A senha não pode ter caracteres especiais, sendo apenas possível informar a até Z e 0 até 9'),
          findsOneWidget);
    });

    testWidgets('Validate field length', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Login()));

      // Enter a long username and password
      await tester.enterText(find.byType(TextFormField).at(0),
          'ThisIsAReallyLongUsernameThatExceeds20Characters');
      await tester.enterText(find.byType(TextFormField).at(1),
          'ThisIsAReallyLongPasswordThatExceeds20Characters');
      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(
          find.text('Deve conter no máximo 20 caracteres'), findsNWidgets(2));
    });

    testWidgets('Validate trailing spaces in fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Login()));

      // Enter username and password with trailing spaces
      await tester.enterText(find.byType(TextFormField).at(0), 'username ');
      await tester.enterText(find.byType(TextFormField).at(1), 'password ');
      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(
          find.text('Último caractere não pode ser espaço'), findsNWidgets(2));
    });
  });
}

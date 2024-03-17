import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_app/presentation/blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:pokemon_app/presentation/screens/login/login_screen.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

class MockLoginScreenBloc extends MockBloc<LoginScreenEvent, LoginScreenState> implements LoginScreenBloc {}

void main() {

  const LoginScreenState mockState = LoginScreenState();
  late LoginScreenBloc loginScreenBloc;

  setUp(() {
    loginScreenBloc = MockLoginScreenBloc();
  });

  group('Testing App Driver Test', () { 
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('', (widgetTester) async {
      when(() => loginScreenBloc.state).thenReturn(mockState);

      await widgetTester.pumpWidget(
        BlocProvider(
          create: (context) => loginScreenBloc,
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        )
      );

      final imageFinder = find.image(const AssetImage('assets/images/pokemon_logo.png'));
      expect(imageFinder, findsOneWidget);

      final customUserFinder = find.byType(CustomTextFormField);
      await widgetTester.enterText(customUserFinder, 'test1@google.com');

      final customPasswordFinder = find.byType(PasswordTextFormField);
      await widgetTester.enterText(customPasswordFinder, 'abc123');

      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text("test1@google.com"), findsOneWidget);
      expect(find.text("abc123"), findsOneWidget);

      final gestureDetectorFinder = find.byKey(const Key('login_screen_gesture_detector'));
      await widgetTester.tap(gestureDetectorFinder);

      final primaryButtonFinder = find.byType(PrimaryButton);
      await widgetTester.tap(primaryButtonFinder);
    });
  });
}
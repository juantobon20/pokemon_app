import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/presentation/blocs/bloc.dart';
import 'package:pokemon_app/presentation/screens/screen.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

class MockLoginScreenBloc extends MockBloc<LoginScreenEvent, LoginScreenState>
    implements LoginScreenBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const LoginScreenState mockState = LoginScreenState();
  late LoginScreenBloc loginScreenBloc;

  setUp(() {
    loginScreenBloc = MockLoginScreenBloc();
  });

  testWidgets('When the screen login opens, it should show the pokemon logo, textFields and primary button', (widgetTester) async {
    when(() => loginScreenBloc.state).thenReturn(mockState);

    await widgetTester.pumpWidget(
      BlocProvider(
        create: (context) => loginScreenBloc,
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      )
    );

    await widgetTester.pumpAndSettle();

    final imageFinder = find.image(const AssetImage('assets/images/pokemon_logo.png'));
    expect(imageFinder, findsOneWidget);

    final customUserFinder = find.text('Usuario');
    expect(customUserFinder, findsOneWidget);

    final customPasswordFinder = find.text('Contraseña');
    expect(customPasswordFinder, findsOneWidget);

    final primaryButtonFinder = find.byType(PrimaryButton);
    expect(primaryButtonFinder, findsOneWidget);
  });
}

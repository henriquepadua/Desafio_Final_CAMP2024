import 'package:Desafio_Final_CAMP2024/views/PokedexView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:Desafio_Final_CAMP2024/controllers/pokedex__controller.dart';
import 'package:Desafio_Final_CAMP2024/models/Pokemon_model.dart';
import 'package:dio/dio.dart';

class MockPokedexController implements PokedexController {
  @override
  Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) {
    // TODO: implement buscandoDadosDosPokemons
    throw UnimplementedError();
  }

  @override
  // TODO: implement dio
  Dio get dio => throw UnimplementedError();
}

void main() {
  late MockPokedexController mockPokedexController;
  late Dio mockDio;

  setUp(() {
    mockPokedexController = MockPokedexController();
    mockDio = Dio();
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Initial state is correct', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: Pokedex()));

    // Verify the initial state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Load more Pokemons updates the list', (WidgetTester tester) async {
    // Mock the data to be returned by the controller
    // when(mockPokedexController.buscandoDadosDosPokemons(any)).thenAnswer((_) async => [
    //   Pokemon(id: 1, name: 'Bulbasaur', imageUrl: 'http://example.com/bulbasaur.png'),
    //   // Add more Pokemon objects as needed for the test
    // ]);

    await tester.pumpWidget(makeTestableWidget(child: Pokedex()));

    // Initially, CircularProgressIndicator should be visible
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the Future to complete
    //await tester.pump();

    // Now, the list should be visible
    //expect(find.byType(GridView), findsOneWidget);
    //expect(find.text('Bulbasaur'), findsOneWidget);

    // Simulate loading more Pokemons
    await tester.tap(find.byIcon(Icons.arrow_downward_outlined));
    await tester.pump();

    // Verify that the list is updated with new Pokemons
    //expect(find.text('Bulbasaur'), findsOneWidget);
    // Add more expectations based on your mocked data
  });

  testWidgets('Search by name returns correct results', (WidgetTester tester) async {
    // Mock the data to be returned by the controller
    // when(mockPokedexController.buscandoDadosDosPokemons(any)).thenAnswer((_) async => [
    //   Pokemon(id: 1, name: 'Bulbasaur', imageUrl: 'http://example.com/bulbasaur.png'),
    //   Pokemon(id: 2, name: 'Ivysaur', imageUrl: 'http://example.com/ivysaur.png'),
    //   // Add more Pokemon objects as needed for the test
    // ]);

    await tester.pumpWidget(makeTestableWidget(child: Pokedex()));

    // Wait for the Future to complete
    await tester.pump();

    // Enter search text
    await tester.enterText(find.byType(TextField), 'Bulbasaur');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Verify that the correct Pokemon is shown
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('Ivysaur'), findsNothing);
  });

  testWidgets('Error message is shown when search fails', (WidgetTester tester) async {
    // Mock the data to be returned by the controller
    //when(mockPokedexController.buscandoDadosDosPokemons(any)).thenThrow(Exception('API error'));

    await tester.pumpWidget(makeTestableWidget(child: Pokedex()));

    // Wait for the Future to complete
    await tester.pump();

    // Simulate loading more Pokemons
    await tester.tap(find.byIcon(Icons.arrow_downward_outlined));
    await tester.pump();

    // Verify that the error message is shown
    expect(find.text('Erro ao carregar mais pokemons: Exception: API error'), findsOneWidget);
  });
}

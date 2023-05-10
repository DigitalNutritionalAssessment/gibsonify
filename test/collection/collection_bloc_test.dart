import 'package:flutter_test/flutter_test.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:mockito/mockito.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

class MockGibsonifyRepository extends Mock implements GibsonifyRepository {}

// TODO:
// class FakeGibsonsForm extends Fake implements GibsonsForm {}

void main() {
  group('CollectionBloc', () {
    late CollectionBloc collectionBloc;

    setUp(() {
      collectionBloc = CollectionBloc(collection: GibsonsForm());
    });

    test('initial selected screen is sensitization screen', () {
      expect(collectionBloc.state.activeStep, SelectedScreen.sensitization);
    });

    // blocTest(
    //   'emits [] when nothing is added',
    //   build: () => CollectionBloc(),
    //   expect: () => [],
    // );
  });
}

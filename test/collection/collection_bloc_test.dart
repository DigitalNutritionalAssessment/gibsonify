import 'package:test/test.dart';
// import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

class MockGibsonifyRepository extends Mock implements GibsonifyRepository {}

// TODO:
// class FakeGibsonsForm extends Fake implements GibsonsForm {}

void main() {
  group('CollectionBloc', () {
    late GibsonifyRepository gibsonifyRepository;

    late CollectionBloc collectionBloc;

    setUp(() {
      gibsonifyRepository = MockGibsonifyRepository();

      collectionBloc = CollectionBloc(gibsonifyRepository: gibsonifyRepository);
    });

    test('initial selected screen is sensitization screen', () {
      expect(collectionBloc.state.selectedScreen, SelectedScreen.sensitization);
    });

    // blocTest(
    //   'emits [] when nothing is added',
    //   build: () => CollectionBloc(),
    //   expect: () => [],
    // );
  });
}

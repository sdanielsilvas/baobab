import 'package:flutter_test/flutter_test.dart';
import 'package:baobab_app/blocs/authentication.dart';
import 'package:mockito/mockito.dart';
//import 'package:user_repository/user_repository.dart';

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}


void main() {

  test('my first unit test', () {
    var answer = 42;
    expect(answer, 42);
  });

}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './number_trivia_state.dart';
import '../../../../core/presentation/util/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia_usecase.dart';
import '../../domain/usecases/get_random_number_trivia_usecase.dart';

part 'number_trivia_event.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  // Dependencies
  final GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;
  final GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase;
  final InputConverter inputConverter;

  // 1- I want to check the constructor properties not a null value
  // 2- I want to change the name of properties in constructor to be shorter
  NumberTriviaBloc({
    @required GetRandomNumberTriviaUseCase randomTrivia,
    @required GetConcreteNumberTriviaUseCase concreteTrivia,
    @required this.inputConverter,
  })  : assert(randomTrivia != null),
        assert(concreteTrivia != null),
        assert(inputConverter != null),
        getRandomNumberTriviaUseCase = randomTrivia,
        getConcreteNumberTriviaUseCase = concreteTrivia;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetNumberTriviaConcreteEvent) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.number);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        // Although the "success case" doesn't interest us with the current test,
        // we still have to handle it somehow.
        (integer) => throw UnimplementedError(),
      );
    }
  }
}

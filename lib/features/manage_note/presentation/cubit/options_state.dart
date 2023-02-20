part of 'options_cubit.dart';

abstract class OptionsState extends Equatable {
  const OptionsState();

  @override
  List<Object> get props => [];
}

class OptionsInitial extends OptionsState {}
class OptionsLocalChanged extends OptionsState {}

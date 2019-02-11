import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  BaseEvent([List props = const []]) : super(props);
}
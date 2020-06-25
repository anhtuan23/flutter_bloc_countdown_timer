import 'package:bloc_timer/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
          timerBloc: BlocProvider.of<TimerBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionButtons({TimerBloc timerBloc}) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(
          onPressed: () =>
              timerBloc.add(TimerStarted(duration: currentState.duration)),
          child: Icon(Icons.play_arrow),
        )
      ];
    }
    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerPaused()),
          child: Icon(Icons.pause),
        ),
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerReset()),
          child: Icon(Icons.replay),
        )
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerResumed()),
          child: Icon(Icons.play_arrow),
        ),
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerReset()),
          child: Icon(Icons.replay),
        )
      ];
    }
    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          onPressed: () => timerBloc.add(TimerReset()),
          child: Icon(Icons.replay),
        )
      ];
    }
  }
}

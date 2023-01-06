enum SmoothGameType {
  gabo,
  pyramid,
}

enum SmoothGameStatus {
  local,
  online,
}

smoothGameTypeFromString(String str) {
  switch (str) {
    case 'gabo':
      return SmoothGameType.gabo;
    case 'pyramid':
      return SmoothGameType.pyramid;
    default:
      return SmoothGameType.gabo;
  }
}

enum SGameStep {
  step1,
  step2,
  step3,
  step4,
  step5,
}

enum SGameState {
  start,
  end,
  play,
  pass,
}

enum SmoothGameMessageType {
  broadcast,
  single,
}

sGameStateFromString(json) {
  switch (json) {
    case 'start':
      return SGameState.start;
    case 'end':
      return SGameState.end;
    default:
      return SGameState.start;
  }
}

smoothGameMessageTypeFromString(json) {
  switch (json) {
    case 'broadcast':
      return SmoothGameMessageType.broadcast;
    case 'single':
      return SmoothGameMessageType.single;
    default:
      return SmoothGameMessageType.broadcast;
  }
}

SGameStep smoothGameStepTypeFromString(json) {
  switch (json) {
    case 'step1':
      return SGameStep.step1;
    case 'step2':
      return SGameStep.step2;
    case 'step3':
      return SGameStep.step3;
    case 'step4':
      return SGameStep.step4;
      case 'step5':
      return SGameStep.step5;
    default:
      return SGameStep.step1;
  }
}

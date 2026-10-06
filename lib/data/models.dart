enum GameStatus {
  live('AO VIVO'),
  scheduled('AGENDADO'),
  finished('FINALIZADO');

  const GameStatus(this.label);
  final String label;
}

class Game {
  const Game({
    required this.round,
    required this.teamA,
    required this.abbrA,
    required this.teamB,
    required this.abbrB,
    required this.score,
    required this.status,
    required this.location,
    required this.time,
  });

  final String round;
  final String teamA;
  final String abbrA;
  final String teamB;
  final String abbrB;
  final String score;
  final GameStatus status;
  final String location;
  final String time;

  bool get isLive => status == GameStatus.live;
}

class Course {
  const Course({
    required this.pos,
    required this.name,
    required this.abbr,
    required this.points,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalDiff,
  });

  final String pos;
  final String name;
  final String abbr;
  final int points;
  final int wins;
  final int draws;
  final int losses;
  final String goalDiff;
}

class RankedPlayer {
  const RankedPlayer({
    required this.pos,
    required this.name,
    required this.course,
    required this.number,
    required this.value,
  });

  final String pos;
  final String name;
  final String course;
  final int number;
  final String value;
}

class MatchEvent {
  const MatchEvent({
    required this.minute,
    required this.icon,
    required this.description,
    required this.team,
  });

  final String minute;
  final String icon;
  final String description;
  final String team;
}

enum NoticeType { result, alert, info }

class Notice {
  const Notice({required this.type, required this.message});

  final NoticeType type;
  final String message;
}

class SquadSheet {
  const SquadSheet({
    required this.name,
    required this.abbr,
    required this.score,
    required this.players,
  });

  final String name;
  final String abbr;
  final int score;
  final List<String> players;
}

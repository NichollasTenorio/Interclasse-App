import 'models.dart';

//MOCK = DADOS FICTÍCIOS
abstract final class MockData {
  // Home
  static const highlights =
      <({String label, String value, String name, String sub})>[
    (
      label: 'Artilheiro',
      value: '8 gols',
      name: 'João Silva',
      sub: 'Desenvolvimento de Sistemas'
    ),
    (label: 'Assistências', value: '6', name: 'M. Costa', sub: 'Nutri'),
    (label: 'Líder', value: '24 pts', name: 'Makerting', sub: 'Rodada 4'),
  ];

  static const upcoming = <Game>[
    Game(
      round: 'Rodada 4',
      teamA: 'Administração',
      abbrA: 'ADM',
      teamB: 'Meio Ambiente',
      abbrB: 'MAI',
      score: '- x -',
      status: GameStatus.scheduled,
      location: 'Quadra B',
      time: '16:00',
    ),
    Game(
      round: 'Rodada 5',
      teamA: 'Desenvolvimento de Sistemas',
      abbrA: 'DS',
      teamB: 'Administração',
      abbrB: 'ADM',
      score: '- x -',
      status: GameStatus.scheduled,
      location: 'Ginásio Principal',
      time: 'Amanhã 14:00',
    ),
  ];

  static const standingsSummary =
      <({String pos, String name, String abbr, String pts})>[
    (pos: '1º', name: 'Desenvolvimento de Sistemas', abbr: 'DS', pts: '24'),
    (pos: '2º', name: 'Nutrição', abbr: 'NUT', pts: '21'),
    (pos: '3º', name: 'Administração', abbr: 'ADM', pts: '18'),
  ];

  static const notices = <Notice>[
    Notice(type: NoticeType.result, message: 'Logística venceu DS por 3 x 0'),
    Notice(
        type: NoticeType.alert,
        message: 'ADM x Meio Ambiente começa em 30 min'),
    Notice(type: NoticeType.alert, message: 'Súmula do jogo DS x LOG publicada'),
  ];

  // Jogos
  static const gameFilters = <String>['Todos', 'Hoje', 'Amanhã', 'Finalizados'];

  static const games = <Game>[
    Game(
      round: 'Rodada 4',
      teamA: 'Desenvolvimento de Sistemas',
      abbrA: 'DS',
      teamB: 'Nutrição',
      abbrB: 'NUT',
      score: '2 x 1',
      status: GameStatus.live,
      location: 'Ginásio Principal',
      time: '14:00',
    ),
    Game(
      round: 'Rodada 4',
      teamA: 'Administração',
      abbrA: 'ADM',
      teamB: 'Meio Ambiente',
      abbrB: 'MAI',
      score: '- x -',
      status: GameStatus.scheduled,
      location: 'Quadra B',
      time: '16:00',
    ),
    Game(
      round: 'Rodada 4',
      teamA: 'Marketing',
      abbrA: 'DS',
      teamB: 'Logística',
      abbrB: 'LOG',
      score: '0 x 3',
      status: GameStatus.finished,
      location: 'Quadra A',
      time: '10:00',
    ),
    Game(
      round: 'Rodada 5',
      teamA: 'Desenvolvimento de Sistemas',
      abbrA: 'DS',
      teamB: 'Administração',
      abbrB: 'ADM',
      score: '- x -',
      status: GameStatus.scheduled,
      location: 'Ginásio Principal',
      time: 'Amanhã 14:00',
    ),
  ];

  // Detalhe da partida
  static const events = <MatchEvent>[
    MatchEvent(
        minute: "12'",
        icon: '⚽',
        description: 'Gol — João Silva',
        team: 'Desenvolvimento de Sistemas'),
    MatchEvent(
        minute: "28'",
        icon: '🟨',
        description: 'Cartão Amarelo — Pedro Alves',
        team: 'Nutrição'),
    MatchEvent(
        minute: "34'",
        icon: '⚽',
        description: 'Gol — Lucas Mendes',
        team: 'Nutrição'),
    MatchEvent(
        minute: "41'",
        icon: '⚽',
        description: 'Gol — Bruno Lima',
        team: 'Desenvolvimento de Sistemas'),
  ];

  static const matchInfo = <(String, String)>[
    ('Competição', 'Interclasse Etec 2026'),
    ('Rodada', '4ª Rodada'),
    ('Data', '08/09/2026'),
    ('Local', 'Ginásio Principal'),
    ('Árbitro', 'Prof. Carlos Ferreira'),
  ];

  static const squads = <SquadSheet>[
    SquadSheet(
      name: 'Desenvolvimento de Sistemas',
      abbr: 'DS',
      score: 2,
      players: [
        '#10 João Silva',
        '#1 Bruno Lima',
        '#5 Carlos Rocha',
        '#3 Paulo Neves',
        '#7 Diego Farias'
      ],
    ),
    SquadSheet(
      name: 'Nutrição',
      abbr: 'NUT',
      score: 1,
      players: [
        '#7 Pedro Alves',
        '#9 Lucas Mendes',
        '#1 André Souza',
        '#4 Felipe Gomes',
        '#11 Thiago Lima'
      ],
    ),
  ];

  /// (label, valA, valB)
  static const matchStats = <(String, int, int)>[
    ('Posse de Bola (%)', 58, 42),
    ('Finalizações', 9, 5),
    ('No Gol', 4, 2),
    ('Faltas', 8, 11),
    ('Escanteios', 5, 2),
  ];

  // Ranking
  static const courses = <Course>[
    Course(
        pos: '1º',
        name: 'Desenvolvimento de Sistemas',
        abbr: 'DS',
        points: 24,
        wins: 8,
        draws: 0,
        losses: 2,
        goalDiff: '+13'),
    Course(
        pos: '2º',
        name: 'Nutrição',
        abbr: 'NUT',
        points: 21,
        wins: 7,
        draws: 0,
        losses: 3,
        goalDiff: '+7'),
    Course(
        pos: '3º',
        name: 'Administração',
        abbr: 'ADM',
        points: 18,
        wins: 6,
        draws: 0,
        losses: 4,
        goalDiff: '+1'),
    Course(
        pos: '4º',
        name: 'Meio Ambiente',
        abbr: 'MAI',
        points: 15,
        wins: 5,
        draws: 0,
        losses: 5,
        goalDiff: '-2'),
    Course(
        pos: '5º',
        name: 'Marketing',
        abbr: 'MKT',
        points: 12,
        wins: 4,
        draws: 0,
        losses: 6,
        goalDiff: '-7'),
    Course(
        pos: '6º',
        name: 'Logística',
        abbr: 'LOG',
        points: 9,
        wins: 3,
        draws: 0,
        losses: 7,
        goalDiff: '-11'),
  ];

  static const playerCategories = <String>[
    'Artilharia',
    'Assistências',
    'Jogos'
  ];

  static const players = <RankedPlayer>[
    RankedPlayer(
        pos: '1',
        name: 'João Silva',
        course: 'Desenvolvimento de Sistemas',
        number: 10,
        value: '8 gols'),
    RankedPlayer(
        pos: '2',
        name: 'Pedro Alves',
        course: 'Nutrição',
        number: 7,
        value: '6 gols'),
    RankedPlayer(
        pos: '3',
        name: 'Lucas Mendes',
        course: 'Administração',
        number: 9,
        value: '5 gols'),
    RankedPlayer(
        pos: '4',
        name: 'Matheus Costa',
        course: 'Meio Ambiente',
        number: 11,
        value: '4 gols'),
    RankedPlayer(
        pos: '5',
        name: 'Rafael Santos',
        course: 'Marketing',
        number: 8,
        value: '3 gols'),
  ];

  // Estatísticas
  static const summaryStats = <({String label, String value, String sub})>[
    (label: 'GOLS', value: '47', sub: '15 partidas'),
    (label: 'MÉDIA/JOGO', value: '3.1', sub: 'gols por partida'),
    (label: 'C. AMARELOS', value: '28', sub: 'no campeonato'),
    (label: 'C. VERMELHOS', value: '3', sub: 'no campeonato'),
  ];

  /// (sigla, gols, máximo)
  static const goalsByCourse = <(String, int, int)>[
    ('DS', 22, 22),
    ('NUT', 19, 22),
    ('ADM', 15, 22),
    ('MAI', 14, 22),
    ('DS', 11, 22),
    ('LOG', 9, 22),
  ];

  /// (nome, curso, gols)
  static const topScorers = <(String, String, int)>[
    ('João Silva', 'Desenvolvimento de Sistemas', 8),
    ('Pedro Alves', 'Nutrição', 6),
    ('Lucas Mendes', 'Administração', 5),
  ];

  /// (modalidade, concluídos, total)
  static const modalities = <(String, int, int)>[
    ('Futsal', 12, 15),
    ('Vôlei', 8, 12),
    ('Basquete', 6, 10),
    ('Tênis de Mesa', 8, 8),
  ];

  // Perfil
  static const profileStats = <(String, String)>[
    ('10', 'Jogos'),
    ('8', 'Gols'),
    ('3', 'Assists'),
    ('8', 'Vitórias'),
  ];

  static const profileInfo = <(String, String)>[
    ('Escola', 'ETEC Zona Sul'),
    ('Curso', 'Téc. em Desenvolvimento de Sistemas'),
    ('Período', '2º Módulo · Tarde'),
    ('RM', '25102'),
  ];

  static const profileToggles = <(String, bool)>[
    ('Notificações de partidas', true),
    ('Avisos do campeonato', true),
    ('Resultados em tempo real', false),
  ];
}

import 'package:flutter/material.dart';

import '../core/ui.dart';
import '../data/mock_data.dart';
import '../data/models.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key, required this.onMatch});

  //Uma constante
  final VoidCallback onMatch;

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  String _filter = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.teal,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Col(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Heading('JOGOS', size: 22, color: AppColors.white),
              ),
              //Widget para deixar a tela rolável
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 14),
                child: HRow(
                  gap: 6,
                  children: [
                    for (final f in MockData.gameFilters)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _filter = f),
                        child: AppChip(label: f, active: _filter == f),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //Usado para cobrir todo o espaço possível de tela
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(14),
            itemCount: MockData.games.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => _GameCard(game: MockData.games[i], onTap: widget.onMatch),
          ),
        ),
      ],
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({required this.game, required this.onTap});

  final Game game;
  final VoidCallback onTap;

  Color get _badgeColor => switch (game.status) {
        GameStatus.live => AppColors.red,
        GameStatus.finished => AppColors.muted,
        GameStatus.scheduled => AppColors.teal,
      };

  @override
  Widget build(BuildContext context) {
    final live = game.isLive;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AppCard(
        borderColor: live ? AppColors.red : AppColors.border,
        borderWidth: live ? 2 : 1,
        child: Col(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: HRow(
                main: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Label('${game.round} · ${game.location}', size: 10)),
                  const SizedBox(width: 8),
                  AppBadge(label: game.status.label, color: _badgeColor),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: HRow(
                gap: 8,
                children: [
                  Expanded(child: TeamColumn(abbr: game.abbrA, name: game.teamA)),
                  Heading(game.score, size: live ? 28 : 18),
                  Expanded(child: TeamColumn(abbr: game.abbrB, name: game.teamB)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

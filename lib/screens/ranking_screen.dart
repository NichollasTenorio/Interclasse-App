import 'package:flutter/material.dart';

import '../core/ui.dart';
import '../data/mock_data.dart';
import '../data/models.dart';

enum RankingTab {
  courses('CURSOS'),
  players('JOGADORES');

  const RankingTab(this.label);
  final String label;
}

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RankingTab _tab = RankingTab.courses;

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
                child: Heading('RANKING', size: 22, color: AppColors.white),
              ),
              TabStrip(
                labels: [for (final t in RankingTab.values) t.label],
                selected: _tab.index,
                onSelect: (i) => setState(() => _tab = RankingTab.values[i]),
                fontSize: 13,
                border: const Border(bottom: BorderSide(color: AppColors.white20)),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: switch (_tab) {
              RankingTab.courses => _courses(),
              RankingTab.players => _players(),
            },
          ),
        ),
      ],
    );
  }

  Widget _courses() {
    final courses = MockData.courses;
    final podium = [courses[1], courses[0], courses[2]];
    const heights = [90.0, 120.0, 70.0];
    const places = ['2º', '1º', '3º'];

    return Col(
      gap: 12,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: HRow(
            gap: 6,
            align: CrossAxisAlignment.end,
            children: [
              for (var pi = 0; pi < 3; pi++)
                Expanded(
                  child: Col(
                    gap: 4,
                    align: CrossAxisAlignment.center,
                    children: [
                      TeamAvatar(abbr: podium[pi].abbr, size: pi == 1 ? 40 : 30),
                      Label(podium[pi].name.split(' ').first,
                          size: 10, color: AppColors.text, weight: FontWeight.w600),
                      Container(
                        width: double.infinity,
                        height: heights[pi],
                        decoration: BoxDecoration(
                          color: pi == 1 ? AppColors.teal : AppColors.placeholder,
                          border: Border.all(color: AppColors.border),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                        child: Col(
                          gap: 2,
                          align: CrossAxisAlignment.center,
                          main: MainAxisAlignment.center,
                          children: [
                            Heading(places[pi],
                                size: pi == 1 ? 18 : 14,
                                color: pi == 1 ? AppColors.white : AppColors.text),
                            Label('${podium[pi].points}pts',
                                size: 11, color: pi == 1 ? AppColors.white80 : AppColors.muted),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        AppCard(child: _table(courses)),
      ],
    );
  }

  Widget _table(List<Course> courses) {
    const headers = ['#', 'Curso', 'PTS', 'V', 'E', 'D', 'SG'];
    return Col(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
          child: Row(
            children: [
              for (var i = 0; i < headers.length; i++)
                if (i == 1)
                  Expanded(child: Label(headers[i], size: 10, weight: FontWeight.w700))
                else
                  SizedBox(
                    width: 28,
                    child: Label(headers[i],
                        size: 10,
                        weight: FontWeight.w700,
                        textAlign: i > 1 ? TextAlign.center : null),
                  ),
            ],
          ),
        ),
        for (var i = 0; i < courses.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Heading(courses[i].pos,
                      size: 13, color: i == 0 ? AppColors.teal : AppColors.muted),
                ),
                Expanded(
                  child: HRow(
                    gap: 8,
                    children: [
                      TeamAvatar(abbr: courses[i].abbr, size: 24),
                      Flexible(
                        child: Label(courses[i].name,
                            color: AppColors.text, weight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                for (final (vi, v) in [
                  '${courses[i].points}',
                  '${courses[i].wins}',
                  '${courses[i].draws}',
                  '${courses[i].losses}',
                  courses[i].goalDiff,
                ].indexed)
                  SizedBox(
                    width: 28,
                    child: Label(v,
                        color: vi == 0 ? AppColors.text : AppColors.muted,
                        weight: vi == 0 ? FontWeight.w700 : FontWeight.w400,
                        textAlign: TextAlign.center),
                  ),
              ],
            ),
          ),
          if (i < courses.length - 1) const HDivider(),
        ],
      ],
    );
  }

  Widget _players() {
    final players = MockData.players;
    return Col(
      gap: 8,
      children: [
        // Chips estáticos
        HRow(
          gap: 6,
          children: [
            for (final cat in MockData.playerCategories)
              AppChip(label: cat, active: cat == 'Artilharia'),
          ],
        ),
        for (var i = 0; i < players.length; i++) _PlayerCard(player: players[i], highlighted: i < 3),
      ],
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({required this.player, required this.highlighted});

  final RankedPlayer player;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: HRow(
        gap: 10,
        children: [
          SizedBox(
            width: 24,
            child: Heading(player.pos, color: highlighted ? AppColors.teal : AppColors.muted),
          ),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.placeholder,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: Label('#${player.number}', size: 13, weight: FontWeight.w700),
          ),
          Expanded(
            child: Col(
              gap: 2,
              children: [
                Label(player.name, size: 14, color: AppColors.text, weight: FontWeight.w600),
                Label(player.course, size: 11),
              ],
            ),
          ),
          Heading(player.value, size: 18, color: AppColors.teal),
        ],
      ),
    );
  }
}

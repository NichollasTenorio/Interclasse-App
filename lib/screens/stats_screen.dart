import 'package:flutter/material.dart';

import '../core/ui.dart';
import '../data/mock_data.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 72),
      child: Col(
        children: [
          Container(
            color: AppColors.teal,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Col(
              align: CrossAxisAlignment.start,
              children: [
                Heading('ESTATÍSTICAS', size: 22, color: AppColors.white),
                Label('Interclasse Etec 2026 · Rodada 4', color: AppColors.white70),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Col(
              gap: 14,
              children: [
                _summaryGrid(),
                _goalsByCourse(),
                _topScorers(),
                _modalities(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryGrid() {
    final s = MockData.summaryStats;
    Widget cell(int i) => Expanded(
          child: AppCard(
            padding: const EdgeInsets.all(12),
            child: Col(
              align: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Label(s[i].label, size: 9, weight: FontWeight.w700),
                ),
                Heading(s[i].value, size: 28, color: AppColors.teal),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Label(s[i].sub, size: 10),
                ),
              ],
            ),
          ),
        );

    return Col(
      gap: 10,
      children: [
        for (var row = 0; row < s.length; row += 2)
          IntrinsicHeight(
            child: HRow(
              gap: 10,
              align: CrossAxisAlignment.stretch,
              children: [cell(row), cell(row + 1)],
            ),
          ),
      ],
    );
  }

  Widget _cardTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Label(text, size: 11, color: AppColors.teal, weight: FontWeight.w700),
      );

  Widget _goalsByCourse() {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Col(
        children: [
          _cardTitle('GOLS POR CURSO'),
          Col(
            gap: 10,
            children: [
              for (final (abbr, goals, max) in MockData.goalsByCourse)
                HRow(
                  gap: 10,
                  children: [
                    SizedBox(width: 32, child: Label(abbr, size: 11, weight: FontWeight.w600)),
                    Expanded(
                      child: BarTrack(
                        height: 5,
                        fraction: goals / max,
                        fill: AppColors.teal,
                        track: AppColors.placeholder,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: Label('$goals',
                          color: AppColors.text, weight: FontWeight.w600, textAlign: TextAlign.right),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _topScorers() {
    final list = MockData.topScorers;
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Col(
        children: [
          _cardTitle('TOP ARTILHEIROS'),
          Col(
            gap: 10,
            children: [
              for (var i = 0; i < list.length; i++)
                Col(
                  children: [
                    HRow(
                      gap: 10,
                      children: [
                        SizedBox(
                          width: 20,
                          child: Label('${i + 1}',
                              size: 13,
                              color: i == 0 ? AppColors.teal : AppColors.muted,
                              weight: FontWeight.w700),
                        ),
                        Expanded(
                          child: Col(
                            gap: 1,
                            children: [
                              Label(list[i].$1, size: 13, color: AppColors.text, weight: FontWeight.w600),
                              Label(list[i].$2, size: 11),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: '${list[i].$3} ',
                            style: Heading.style(16, AppColors.teal, FontWeight.w700),
                            children: [
                              TextSpan(
                                text: 'gols',
                                style: Label.style(10, AppColors.muted, FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (i < list.length - 1) const HDivider(topMargin: 10),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _modalities() {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Col(
        children: [
          _cardTitle('MODALIDADES'),
          Col(
            gap: 10,
            children: [
              for (final (name, done, total) in MockData.modalities)
                ProgBar(label: name, pct: done / total * 100, value: '$done/$total'),
            ],
          ),
        ],
      ),
    );
  }
}

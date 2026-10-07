import 'package:flutter/material.dart';

import '../core/ui.dart';
import '../data/mock_data.dart';
import '../data/models.dart';

enum MatchTab {
  summary('RESUMO'),
  sheet('SÚMULA'),
  stats('ESTATÍSTICAS');

  const MatchTab(this.label);
  final String label;
}

class MatchDetailScreen extends StatefulWidget {
  const MatchDetailScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  MatchTab _tab = MatchTab.summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _header(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: switch (_tab) {
              MatchTab.summary => _summary(),
              MatchTab.sheet => _sheet(),
              MatchTab.stats => _stats(),
            },
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      color: AppColors.teal,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      child: Col(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.onBack,
                child: HRow(
                  gap: 6,
                  main: MainAxisAlignment.start,
                  children: [
                    const SvgIcon(AppIcons.back, color: AppColors.teal),
                    Label('Jogos', size: 13, color: AppColors.white, weight: FontWeight.w500),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: HRow(
              main: MainAxisAlignment.spaceBetween,
              children: [
                Label('RODADA 4 · FASE DE GRUPOS', size: 10, color: AppColors.white60),
                const AppBadge(label: 'AO VIVO', color: AppColors.red),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: HRow(
              gap: 8,
              children: [
                const Expanded(
                  child: TeamColumn(
                    abbr: 'DS', name: 'Desenvolvimento de Sistemas',
                    avatarSize: 48, nameSize: 13, nameColor: AppColors.white,
                    nameWeight: FontWeight.w600, gap: 6,
                  ),
                ),
                Col(
                  gap: 2,
                  align: CrossAxisAlignment.center,
                  children: [
                    Heading('2 x 1', size: 44, color: AppColors.white),
                    Label('2º TEMPO · 08:32', size: 10, color: AppColors.white60),
                    Label('Ginásio Principal', size: 10, color: AppColors.white50),
                  ],
                ),
                const Expanded(
                  child: TeamColumn(
                    abbr: 'MKT', name: 'Marketing',
                    avatarSize: 48, nameSize: 13, nameColor: AppColors.white,
                    nameWeight: FontWeight.w600, gap: 6,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: TabStrip(
              labels: [for (final t in MatchTab.values) t.label],
              selected: _tab.index,
              onSelect: (i) => setState(() => _tab = MatchTab.values[i]),
              fontSize: 11,
              border: const Border(top: BorderSide(color: AppColors.white20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summary() {
    final events = MockData.events;
    return Col(
      children: [
        for (var i = 0; i < events.length; i++) _EventRow(event: events[i], showLine: i < events.length - 1),
      ],
    );
  }

  Widget _sheet() {
    return Col(
      gap: 12,
      children: [
        AppCard(
          padding: const EdgeInsets.all(12),
          child: Col(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Label('INFORMAÇÕES', size: 10, color: AppColors.teal, weight: FontWeight.w700),
              ),
              for (final (k, v) in MockData.matchInfo) KeyValueRow(label: k, value: v, spacing: 7),
            ],
          ),
        ),
        for (final t in MockData.squads) _SquadCard(squad: t),
      ],
    );
  }

  Widget _stats() {
    final stats = MockData.matchStats;
    return Col(
      gap: 10,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
          child: HRow(
            main: MainAxisAlignment.spaceBetween,
            children: [
              const TeamAvatar(abbr: 'INF', size: 28),
              Label('COMPARATIVO', size: 11, weight: FontWeight.w600),
              const TeamAvatar(abbr: 'MEC', size: 28),
            ],
          ),
        ),
        AppCard(
          padding: const EdgeInsets.all(12),
          child: Col(
            gap: 12,
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                StatBar(label: stats[i].$1, valA: stats[i].$2, valB: stats[i].$3),
                if (i < stats.length - 1) const HDivider(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event, required this.showLine});

  final MatchEvent event;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showLine)
          Positioned(left: 52, top: 28, bottom: 0, width: 1, child: const ColoredBox(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: HRow(
            gap: 10,
            children: [
              SizedBox(
                width: 32,
                child: Label(event.minute,
                    size: 13, color: AppColors.teal, weight: FontWeight.w700, textAlign: TextAlign.right),
              ),
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(event.icon, style: const TextStyle(fontSize: 13)),
              ),
              Flexible(
                child: Col(
                  gap: 1,
                  children: [
                    Label(event.description, size: 13, color: AppColors.text, weight: FontWeight.w500),
                    Label(event.team, size: 11),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SquadCard extends StatelessWidget {
  const _SquadCard({required this.squad});

  final SquadSheet squad;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Col(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: HRow(
              gap: 8,
              children: [
                TeamAvatar(abbr: squad.abbr, size: 28),
                Expanded(child: Label(squad.name, size: 14, color: AppColors.text, weight: FontWeight.w700)),
                Heading('${squad.score}', size: 18, color: AppColors.teal),
              ],
            ),
          ),
          for (final p in squad.players)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Label(p, color: AppColors.text),
            ),
        ],
      ),
    );
  }
}

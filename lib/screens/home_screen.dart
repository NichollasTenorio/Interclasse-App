import 'package:flutter/material.dart';

import '../core/ui.dart';
import '../data/mock_data.dart';
import '../data/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onMatch});

  final VoidCallback onMatch;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 72),
      child: Col(
        children: [
          _header(),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Col(
              gap: 18,
              children: [
                _liveSection(),
                _highlightsSection(),
                _upcomingSection(),
                _standingsSection(),
                _noticesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      color: AppColors.teal,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Col(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: HRow(
              main: MainAxisAlignment.spaceBetween,
              children: [
                Col(
                  gap: 3,
                  align: CrossAxisAlignment.start,
                  children: [
                    Label('CENTRO PAULA SOUZA · ETEC',
                        size: 10, color: AppColors.highlight, weight: FontWeight.w700),
                    Heading('INTERCLASSE 2026', size: 20, color: AppColors.white),
                    Label('Rodada 4 de 10', color: AppColors.white70),
                  ],
                ),
                const _Bell(),
              ],
            ),
          ),
          const BarTrack(height: 4, fraction: 0.4, fill: AppColors.highlight, track: AppColors.white20),
        ],
      ),
    );
  }

  Widget _liveSection() {
    return Section(
      title: 'Ao Vivo',
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onMatch,
          child: AppCard(
            borderColor: AppColors.red,
            borderWidth: 2,
            child: Col(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                  child: HRow(
                    gap: 6,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                      ),
                      Label('AO VIVO · 2º TEMPO 08:32',
                          size: 11, color: AppColors.white, weight: FontWeight.w700),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  child: HRow(
                    gap: 8,
                    children: [
                      const Expanded(
                        child: TeamColumn(
                          abbr: 'INFO', name: 'Informática',
                          avatarSize: 44, nameSize: 12, nameWeight: FontWeight.w600, gap: 6,
                        ),
                      ),
                      Col(
                        gap: 2,
                        align: CrossAxisAlignment.center,
                        children: [
                          Heading('2 x 1', size: 36),
                          Label('Ginásio Principal', size: 10),
                        ],
                      ),
                      const Expanded(
                        child: TeamColumn(
                          abbr: 'MEC', name: 'Mecatrônica',
                          avatarSize: 44, nameSize: 12, nameWeight: FontWeight.w600, gap: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _highlightsSection() {
    return Section(
      title: 'Destaques',
      children: [
        IntrinsicHeight(
          child: HRow(
            gap: 8,
            align: CrossAxisAlignment.stretch,
            children: [
              for (final d in MockData.highlights)
                Expanded(
                  child: AppCard(
                    padding: const EdgeInsets.all(10),
                    child: Col(
                      align: CrossAxisAlignment.start,
                      children: [
                        Label(d.label.toUpperCase(), size: 9),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Heading(d.value, size: 18, color: AppColors.teal),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Label(d.name, size: 11, color: AppColors.text, weight: FontWeight.w500),
                        ),
                        Label(d.sub, size: 10),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _upcomingSection() {
    return Section(
      title: 'Próximos Jogos',
      children: [
        for (final m in MockData.upcoming)
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Col(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: HRow(
                    main: MainAxisAlignment.spaceBetween,
                    children: [
                      Label(m.round, size: 10),
                      AppBadge(label: m.status.label),
                    ],
                  ),
                ),
                HRow(
                  gap: 8,
                  children: [
                    Expanded(child: TeamColumn(abbr: m.abbrA, name: m.teamA, avatarSize: 32)),
                    Col(
                      gap: 2,
                      align: CrossAxisAlignment.center,
                      children: [
                        Heading(m.time, size: 14, color: AppColors.muted),
                        Label(m.location, size: 10),
                      ],
                    ),
                    Expanded(child: TeamColumn(abbr: m.abbrB, name: m.teamB, avatarSize: 32)),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _standingsSection() {
    final rows = MockData.standingsSummary;
    return Section(
      title: 'Classificação',
      children: [
        AppCard(
          child: Col(
            children: [
              for (var i = 0; i < rows.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: HRow(
                    gap: 10,
                    children: [
                      SizedBox(
                        width: 24,
                        child: Heading(rows[i].pos,
                            size: 14, color: i == 0 ? AppColors.teal : AppColors.muted),
                      ),
                      TeamAvatar(abbr: rows[i].abbr, size: 28),
                      Expanded(
                        child: Label(rows[i].name,
                            size: 13, color: AppColors.text, weight: FontWeight.w500),
                      ),
                      Text.rich(
                        TextSpan(
                          text: '${rows[i].pts} ',
                          style: Heading.style(14, AppColors.text, FontWeight.w700),
                          children: [
                            TextSpan(
                              text: 'pts',
                              style: Label.style(10, AppColors.muted, FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < rows.length - 1) const HDivider(),
              ],
              const HDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Label('Ver classificação completa →',
                    color: AppColors.teal, weight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _noticesSection() {
    return Section(
      title: 'Avisos',
      children: [
        for (final n in MockData.notices)
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: HRow(
              gap: 10,
              align: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: _noticeColor(n.type), shape: BoxShape.circle),
                  ),
                ),
                Expanded(child: Label(n.message, color: AppColors.text)),
              ],
            ),
          ),
      ],
    );
  }

  static Color _noticeColor(NoticeType type) => switch (type) {
        NoticeType.result => AppColors.success,
        NoticeType.alert => AppColors.warning,
        NoticeType.info => AppColors.teal,
      };
}

class _Bell extends StatelessWidget {
  const _Bell();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white30),
            ),
            child: const SvgIcon(AppIcons.bell, size: 18, color: AppColors.surface),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.red,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.teal, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
